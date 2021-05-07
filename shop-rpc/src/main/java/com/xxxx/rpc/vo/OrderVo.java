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
    private String orderStatus;

    /**
     * 下单时间
     */
    private String addTime;

    /**
     * 收货确认时间
     */
    private String confirmTime;

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

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getAddTime() {
        return addTime;
    }

    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public String getConfirmTime() {
        return confirmTime;
    }

    public void setConfirmTime(String confirmTime) {
        this.confirmTime = confirmTime;
    }

    @Override
    public String toString() {
        return "OrderVo{" +
                "orderSn='" + orderSn + '\'' +
                ", userName='" + userName + '\'' +
                ", orderStatus=" + orderStatus +
                ", addTime=" + addTime +
                ", confirmTime=" + confirmTime +
                ", totalAmount=" + totalAmount +
                '}';
    }
}
