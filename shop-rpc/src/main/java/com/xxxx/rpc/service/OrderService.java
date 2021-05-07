package com.xxxx.rpc.service;

import com.xxxx.common.enums.OrderStatus;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.common.pojo.Order;
import com.xxxx.rpc.vo.CartResult;

import java.util.List;

/**
 * 订单服务
 *
 * @author zhoubin
 * @since 1.0.0
 */
public interface OrderService {

    /**
     * 生成订单
     *
     * @param admin
     * @param cartResult
     * @return
     */
    BaseResult orderSave(Admin admin, CartResult cartResult);

    /**
     * 通过订单编号查询订单
     *
     * @param orderSn
     * @return
     */
    Order selectOrderByOrderSn(String orderSn);

    /**
     * 通过userId查询订单
     *
     * @param admin
     * @return
     */
    List<Order> selectOrderByUserId(Admin admin);

    /**
     * 查询订单
     *
     * @return
     */
    BaseResult selectAllOrders(Admin admin, Integer pageNum);

    /**
     * 更新订单状态
     * @param orderId
     * @return
     */
    BaseResult updateOrder(Integer orderId, OrderStatus orderStatus);

    /**
     * 搜索待发货订单
     * @return
     */
    BaseResult selectToBeDeliveredOrder(Admin admin, Integer pageNum);
}