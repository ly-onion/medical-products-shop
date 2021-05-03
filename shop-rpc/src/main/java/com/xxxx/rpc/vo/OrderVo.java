package com.xxxx.rpc.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/4 0:22
 */
public class OrderVo implements Serializable {

    /**
     * 订单编号
     */
    private String orderSn;

    /**
     * 用户id
     */
    private String userName;

    /**
     * 订单状态
     */
    private Byte orderStatus;

    /**
     * 支付状态
     */
    private Byte payStatus;

    /**
     * 订单总价
     */
    private BigDecimal totalAmount;

    public String getOrderSn() {
        return orderSn;
    }

    public void setOrderSn(String orderSn) {
        this.orderSn = orderSn;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Byte getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Byte orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Byte getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(Byte payStatus) {
        this.payStatus = payStatus;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    @Override
    public String toString() {
        return "OrderVo{" +
                "orderSn='" + orderSn + '\'' +
                ", userName=" + userName +
                ", orderStatus=" + orderStatus +
                ", payStatus=" + payStatus +
                ", totalAmount=" + totalAmount +
                '}';
    }
}
