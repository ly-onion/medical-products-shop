package com.xxxx.order.service.impl;

import com.alibaba.dubbo.common.utils.CollectionUtils;
import com.xxxx.common.enums.OrderStatus;
import com.xxxx.common.enums.PayStatus;
import com.xxxx.common.enums.PromTypeStatus;
import com.xxxx.common.enums.SendStatus;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.order.mapper.OrderGoodsMapper;
import com.xxxx.order.mapper.OrderMapper;
import com.xxxx.order.pojo.Order;
import com.xxxx.order.pojo.OrderExample;
import com.xxxx.order.pojo.OrderGoods;
import com.xxxx.order.service.OrderService;
import com.xxxx.rpc.vo.CartResult;
import com.xxxx.rpc.vo.CartVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.support.atomic.RedisAtomicLong;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * 订单服务实现类
 *
 * @author zhoubin
 * @since 1.0.0
 */
@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderMapper orderMapper;
	@Autowired
	private OrderGoodsMapper orderGoodsMapper;
	@Autowired
	private RedisTemplate<String,String> redisTemplate;
	@Value("${redis.order.increment}")
	private String redisOrderIncrement;

	/**
	 * 生成订单
	 * @param admin
	 * @param cartResult
	 * @return
	 */
	@Override
	public BaseResult orderSave(Admin admin, CartResult cartResult) {
		//创建order对象
		Order order = new Order();
		//订单编号 shop_年月日时分秒_自增key
		String orderSn = DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now())+"_"+getIncrement(redisOrderIncrement);
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
		//应付金额
		order.setOrderAmount(cartResult.getTotalPrice());
		//订单总价
		order.setTotalAmount(cartResult.getTotalPrice());
		//订单时间
		Long addTime = LocalDateTime.now().toEpochSecond(ZoneOffset.of("+8"));
		order.setAddTime(addTime.intValue());
		int result = orderMapper.insertSelective(order);
		//存储成功
		if (result>0){
			List<OrderGoods> orderGoodsList  = new ArrayList<>();
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
			if (result>0){
				BaseResult baseResult = BaseResult.success();
				baseResult.setMessage(orderSn);
				return baseResult;
			}
		}
		return BaseResult.error();
	}

	/**
	 * 通过订单编号查询订单
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
		if (CollectionUtils.isEmpty(orders)||orders.size()>1){
			return null;
		}
		return orders.get(0);
	}

	/**
	 * redis自增key
	 * @param key
	 * @return
	 */
	private Long getIncrement(String key){
		RedisAtomicLong entityIdCounter = new RedisAtomicLong(key,redisTemplate.getConnectionFactory());
		return entityIdCounter.getAndIncrement();
	}
}