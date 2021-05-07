package com.xxxx.rpc.service.impl;

import com.alibaba.dubbo.common.utils.CollectionUtils;
import com.alibaba.dubbo.config.annotation.Service;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xxxx.common.enums.OrderStatus;
import com.xxxx.common.enums.PayStatus;
import com.xxxx.common.enums.PromTypeStatus;
import com.xxxx.common.enums.SendStatus;
import com.xxxx.common.pojo.*;
import com.xxxx.common.result.BaseResult;
import com.xxxx.common.util.JsonUtil;
import com.xxxx.common.util.TimeExchange;
import com.xxxx.rpc.mapper.AdminMapper;
import com.xxxx.rpc.mapper.OrderGoodsMapper;
import com.xxxx.rpc.mapper.OrderMapper;
import com.xxxx.rpc.service.OrderService;
import com.xxxx.rpc.vo.CartResult;
import com.xxxx.rpc.vo.CartVo;
import com.xxxx.rpc.vo.GoodsVo;
import com.xxxx.rpc.vo.OrderVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.data.redis.support.atomic.RedisAtomicLong;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * 订单服务实现类
 *
 * @author zhoubin
 * @since 1.0.0
 */
@Service(interfaceClass = OrderService.class)
@Component
public class OrderServiceImpl implements OrderService {

    @Resource
    private OrderMapper orderMapper;
    @Resource
    private OrderGoodsMapper orderGoodsMapper;
    @Resource
    private AdminMapper adminMapper;
    @Resource
    private RedisTemplate<String, String> redisTemplate;
    @Value("${redis.order.increment}")
    private String redisOrderIncrement;

    /**
     * 生成订单
     *
     * @param admin
     * @param cartResult
     * @return
     */
    @Override
    public BaseResult orderSave(Admin admin, CartResult cartResult) {
        //创建order对象
        Order order = new Order();
        //订单编号 shop_年月日时分秒_自增key
        String orderSn = DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now()) + "_" + getIncrement(redisOrderIncrement);
        order.setOrderSn(orderSn);
        //用户id
        order.setUserId(admin.getAdminId().intValue());
        //订单状态(未确认)
        order.setOrderStatus(OrderStatus.no_confirm.getStatus());
        //发货状态(未发货)
        order.setShippingStatus(SendStatus.no_pay.getStatus());
        //支付状态(未支付)
        order.setPayStatus(PayStatus.no_pay.getStatus());
        //商品总价
        order.setGoodsPrice(cartResult.getTotalPrice());
        //订单总价
        order.setTotalAmount(cartResult.getTotalPrice());
        //订单时间
        Long addTime = LocalDateTime.now().toEpochSecond(ZoneOffset.of("+8"));
        order.setAddTime(addTime.intValue());
        int result = orderMapper.insertSelective(order);
        //存储成功
        if (result > 0) {
            List<OrderGoods> orderGoodsList = new ArrayList<>();
            for (CartVo cartVo : cartResult.getCartList()) {
                //创建orderGoods对象
                OrderGoods orderGoods = new OrderGoods();
                //订单id
                orderGoods.setOrderId(order.getOrderId());
                //商品id
                orderGoods.setGoodsId(cartVo.getGoodsId());
                //商品名称
                orderGoods.setGoodsName(cartVo.getGoodsName());
                //商品价格
                orderGoods.setGoodsPrice(cartVo.getMarketPrice());
                //商品数量
                orderGoods.setGoodsNum(cartVo.getGoodsNum().shortValue());
                //订单方式
                orderGoods.setPromType(PromTypeStatus.normal.getStatus());
                //发货状态
                orderGoods.setIsSend(SendStatus.no_pay.getStatus());
                //添加到订单商品对象列表
                orderGoodsList.add(orderGoods);
            }
            //批量插入
            result = orderGoodsMapper.insertOrderGoodsBatch(orderGoodsList);
            if (result > 0) {
                BaseResult baseResult = BaseResult.success();
                baseResult.setMessage(orderSn);
                return baseResult;
            }
        }
        return BaseResult.error();
    }

    /**
     * 通过订单编号查询订单
     *
     * @param orderSn
     * @return
     */
    @Override
    public Order selectOrderByOrderSn(String orderSn) {
        //创建查询对象
        OrderExample example = new OrderExample();
        //创建查询条件
        example.createCriteria().andOrderSnEqualTo(orderSn);
        List<Order> orders = orderMapper.selectByExample(example);
        //健壮性判断
        if (CollectionUtils.isEmpty(orders) || orders.size() > 1) {
            return null;
        }
        return orders.get(0);
    }

    /**
     * 通过userId查询订单
     *
     * @param admin
     * @return
     */
    @Override
    public List<Order> selectOrderByUserId(Admin admin) {
        OrderExample example = new OrderExample();
        example.createCriteria().andUserIdEqualTo(Integer.valueOf(admin.getAdminId()));
        List<Order> orders = orderMapper.selectByExample(example);
        return orders;
    }

    /**
     * 查询所有订单
     *
     * @return
     */
    @Override
    public BaseResult selectAllOrders(Admin admin, Integer pageNum) {
        //定义RedisKey数组
        String[] ordersKeyArr = new String[]{
                "orders:pageNum_" + pageNum,
                "userId_:"
        };
        //构建分页对象
        Page<Object> page = PageHelper.startPage(pageNum, 10);
        OrderExample example = new OrderExample();
        if (admin == null) {
            List<Order> orderList = orderMapper.selectByExample(example);
            if (!CollectionUtils.isEmpty(orderList)) {
                Page<OrderVo> orderVoList = copyList(orderList);
                PageInfo<OrderVo> pageInfo = new PageInfo<>(orderVoList);
                return BaseResult.success(pageInfo);
            } else {
                return BaseResult.error();
            }
        } else {
            ordersKeyArr[1] = "userId_" + admin.getAdminId() + ":";
            //拼接完整的RedisKey
            String ordersListKey = Arrays.stream(ordersKeyArr).collect(Collectors.joining());
            ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
            //查询缓存，如果缓存中存在数据，直接返回
            String pageInfoOrdersJson = valueOperations.get(ordersListKey);
            if (!StringUtils.isEmpty(pageInfoOrdersJson)) {
                return BaseResult.success(JsonUtil.jsonStr2Object(pageInfoOrdersJson, PageInfo.class));
            }
            example.createCriteria().andUserIdEqualTo(Integer.valueOf(admin.getAdminId()));
            List<Order> orderList = orderMapper.selectByExample(example);
            if (!CollectionUtils.isEmpty(orderList)) {
                Page<OrderVo> orderVosList = copyList(orderList);
                PageInfo<OrderVo> pageInfo = new PageInfo<>(orderVosList);
                //放入redis缓存
                valueOperations.set(ordersListKey, JsonUtil.object2JsonStr(pageInfo));
                return BaseResult.success(pageInfo);
            } else {
                //如果没有数据，将空数据放入缓存，设置失效时间60s
                valueOperations.set(ordersListKey,
                        JsonUtil.object2JsonStr(new PageInfo<>(new ArrayList<OrderVo>())), 60, TimeUnit.SECONDS);
                return BaseResult.error();
            }
        }
    }

    /**
     * 更新订单状态
     *
     * @param orderId
     * @return
     */
    @Override
    public BaseResult updateOrder(Integer orderId, OrderStatus orderStatus) {
        Order order = new Order();
        order.setOrderId(orderId);
        Byte byteStatus = orderStatus.getStatus();
        order.setOrderStatus(byteStatus);
        if (byteStatus == 4) {
            order.setConfirmTime((int) LocalDateTime.now().toEpochSecond(ZoneOffset.of("+8")));
        }
        int result = orderMapper.updateByPrimaryKeySelective(order);
        return result>0?BaseResult.success():BaseResult.error();
    }

    public Page<OrderVo> copyList(List<Order> source) {
        Page<OrderVo> target = new Page<>();
        BeanUtils.copyProperties(source, target);
        for (Order order : source) {
            OrderVo orderVo = new OrderVo();
            BeanUtils.copyProperties(order, orderVo);
            Admin admin = adminMapper.selectByPrimaryKey(order.getUserId().shortValue());
            orderVo.setUserName(admin.getUserName());
            orderVo.setOrderStatus(OrderStatus.findStatus(order.getOrderStatus()).getMessage());
            orderVo.setAddTime(TimeExchange.timestampToString(order.getAddTime()));
            orderVo.setConfirmTime(TimeExchange.timestampToString(order.getConfirmTime()));
            target.add(orderVo);
        }
        return target;
    }

    /**
     * 搜索待发货订单
     *
     * @return
     */
    @Override
    public BaseResult selectToBeDeliveredOrder(Admin admin, Integer pageNum) {
        //定义RedisKey数组
        String[] ordersKeyArr = new String[]{
                "orders:undelivered:pageNum_" + pageNum,
                "userId_:"
        };
        //构建分页对象
        Page<Object> page = PageHelper.startPage(pageNum, 10);
        OrderExample example = new OrderExample();
        OrderExample.Criteria criteria = example.createCriteria();
        criteria.andOrderStatusEqualTo((byte) 2);
        if (admin == null) {
            List<Order> orderList = orderMapper.selectByExample(example);
            if (!CollectionUtils.isEmpty(orderList)) {
                Page<OrderVo> orderVoList = copyList(orderList);
                PageInfo<OrderVo> pageInfo = new PageInfo<>(orderVoList);
                return BaseResult.success(pageInfo);
            } else {
                return BaseResult.error();
            }
        } else {
            ordersKeyArr[1] = "userId_" + admin.getAdminId() + ":";
            //拼接完整的RedisKey
            String ordersListKey = Arrays.stream(ordersKeyArr).collect(Collectors.joining());
            ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
            //查询缓存，如果缓存中存在数据，直接返回
            String pageInfoOrdersJson = valueOperations.get(ordersListKey);
            if (!StringUtils.isEmpty(pageInfoOrdersJson)) {
                return BaseResult.success(JsonUtil.jsonStr2Object(pageInfoOrdersJson, PageInfo.class));
            }
            criteria.andUserIdEqualTo(Integer.valueOf(admin.getAdminId()));
            List<Order> orderList = orderMapper.selectByExample(example);
            if (!CollectionUtils.isEmpty(orderList)) {
                Page<OrderVo> orderVosList = copyList(orderList);
                PageInfo<OrderVo> pageInfo = new PageInfo<>(orderVosList);
                //放入redis缓存
                valueOperations.set(ordersListKey, JsonUtil.object2JsonStr(pageInfo));
                return BaseResult.success(pageInfo);
            } else {
                //如果没有数据，将空数据放入缓存，设置失效时间60s
                valueOperations.set(ordersListKey,
                        JsonUtil.object2JsonStr(new PageInfo<>(new ArrayList<OrderVo>())), 60, TimeUnit.SECONDS);
                return BaseResult.error();
            }
        }
    }

    /**
     * redis自增key
     *
     * @param key
     * @return
     */
    private Long getIncrement(String key) {
        RedisAtomicLong entityIdCounter = new RedisAtomicLong(key, redisTemplate.getConnectionFactory());
        return entityIdCounter.getAndIncrement();
    }


}