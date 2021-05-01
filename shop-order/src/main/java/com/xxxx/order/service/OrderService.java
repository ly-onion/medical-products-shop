package com.xxxx.order.service;

import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.order.pojo.Order;
import com.xxxx.rpc.vo.CartResult;

/**
 * 订单服务
 *
 * @author zhoubin
 * @since 1.0.0
 */
public interface OrderService {

	/**
	 * 生成订单
	 * @param admin
	 * @param cartResult
	 * @return
	 */
	BaseResult orderSave(Admin admin, CartResult cartResult);

	/**
	 * 通过订单编号查询订单
	 * @param orderSn
	 * @return
	 */
	Order selectOrderByOrderSn(String orderSn);
}