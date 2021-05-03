package com.xxxx.rpc.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.common.util.JsonUtil;
import com.xxxx.rpc.service.CartService;
import com.xxxx.rpc.vo.CartResult;
import com.xxxx.rpc.vo.CartVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/28 21:51
 */
@Service(interfaceClass = CartService.class)
@Component
public class CartServiceImpl implements CartService {

    private HashOperations<String, String, String> hashOperations = null;
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    @Value("${user.cart}")
    private String userCart;

    /**
     * 加入购物车
     *
     * @param cartVo
     * @param admin
     * @return
     */
    @Override
    public BaseResult addCart(CartVo cartVo, Admin admin) {
        if (null == admin || null == admin.getAdminId()) {
            return BaseResult.error();
        }
        Short userId = admin.getAdminId();
        hashOperations = redisTemplate.opsForHash();
        Map<String, String> cartMap = hashOperations.entries(userCart + ":" + userId);
        if (!CollectionUtils.isEmpty(cartMap)) {
            //如果购物车信息不为空，修改购物车信息
            //根据商品Id获取购物车信息
            String cartStr = cartMap.get(String.valueOf(cartVo.getGoodsId()));
            if (!StringUtils.isEmpty(cartStr)) {
                //如果商品存在修改商品数量和价格
                CartVo vo = JsonUtil.jsonStr2Object(cartStr, CartVo.class);
                vo.setGoodsNum(vo.getGoodsNum() + cartVo.getGoodsNum());
                //修改商品最新价格
                vo.setMarketPrice(cartVo.getMarketPrice());
                //重新添加map,覆盖之前的商品对象
                cartMap.put(String.valueOf(vo.getGoodsId()), JsonUtil.object2JsonStr(vo));
            } else {
                //如果商品不存在，直接添加购物车信息
                cartMap.put(String.valueOf(cartVo.getGoodsId()), JsonUtil.object2JsonStr(cartVo));
            }
        } else {
            //如果购物车信息为空，新增购物车信息
            cartMap = new HashMap<>();
            cartMap.put(String.valueOf(cartVo.getGoodsId()), JsonUtil.object2JsonStr(cartVo));
        }
        hashOperations.putAll(userCart + ":" + userId, cartMap);
        return BaseResult.success();

    }


    /**
     * 查询购物车数量
     *
     * @param admin
     * @return
     */
    @Override
    public Integer getCartNum(Admin admin) {
        if (null == admin || null == admin.getAdminId()) {
            return 0;
        }
        Integer result = 0;
        hashOperations = redisTemplate.opsForHash();
        Map<String, String> cartMap = hashOperations.entries(userCart + ":" + admin.getAdminId());
        //如果购物车信息不为空，累加购物车数量
        if (!CollectionUtils.isEmpty(cartMap)) {
            for (Map.Entry<String, String> entry : cartMap.entrySet()) {
                CartVo cartVo = JsonUtil.jsonStr2Object(entry.getValue(), CartVo.class);
                result += cartVo.getGoodsNum();
            }
        }
        return result;
    }

    /**
     * 获取购物车列表
     *
     * @param admin
     * @return
     */
    @Override
    public CartResult getCartList(Admin admin) {
        if (null == admin || null == admin.getAdminId()) {
            return null;
        }
        //初始化返回对象
        CartResult cartResult = null;
        //从redis获取购物车信息
        hashOperations = redisTemplate.opsForHash();
        Map<String, String> cartMap = hashOperations.entries(userCart + ":" + admin.getAdminId());
        if (!CollectionUtils.isEmpty(cartMap)) {
            //如果存在
            cartResult = new CartResult();
            //购物车列表信息
            List<CartVo> cartList = cartMap.values().stream()
                    .map(e -> JsonUtil.jsonStr2Object(e, CartVo.class))
                    .collect(Collectors.toList());
            //总价
            BigDecimal totalPrice = cartList.stream()
                    .map(e -> e.getMarketPrice().multiply(new BigDecimal(String.valueOf(e.getGoodsNum()))))
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            //保留小数点后两位，四舍五入
            totalPrice.setScale(2, BigDecimal.ROUND_HALF_UP);
            cartResult.setCartList(cartList);
            cartResult.setTotalPrice(totalPrice);
        }
        return cartResult;
    }

    /**
     * 清除购物车
     *
     * @param admin
     * @return
     */
    @Override
    public BaseResult clearCart(Admin admin) {
        //判断用户是否存在
        if (null == admin || null == admin.getAdminId()) {
            return null;
        }
        //获取购物车信息
        hashOperations = redisTemplate.opsForHash();
        Map<String, String> cartMap = hashOperations.entries(userCart + ":" + admin.getAdminId());
        if (CollectionUtils.isEmpty(cartMap)) {
            return BaseResult.error();
        }
        redisTemplate.delete(userCart + ":" + admin.getAdminId());
        return BaseResult.success();
    }

    /**
     * 删除购物车中一件商品
     *
     * @param cartVo
     * @return
     */
    @Override
    public BaseResult deleteCartGood(CartVo cartVo, Admin admin) {
        if (null == admin || null == admin.getAdminId()) {
            return BaseResult.error();
        }
        hashOperations = redisTemplate.opsForHash();
        hashOperations.delete(userCart + ":" + admin.getAdminId(), String.valueOf(cartVo.getGoodsId()));
        return BaseResult.success();
    }
}
