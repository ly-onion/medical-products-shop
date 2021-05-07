package com.xxxx.common.enums;

/**
 * @see : 订单状态枚举类
 * @author : zhoubin
 */
public enum OrderStatus {
    // 0待确认 1已确认 2已收货 3已取消 4已完成 5已作废
    no_confirm((byte) 0, "待支付"),
    has_confirm((byte) 1, "已支付"),
    has_recieved((byte) 2, "待发货"),
    cancled((byte) 3, "已发货"),
    completed((byte) 4, "已完成"),
    discard((byte) 5, "已作废");

    // 状态
    private Byte status;
    // 描述
    private String message;

    // 自定义构造器
    private OrderStatus(Byte status, String message) {
        this.status = status;
        this.message = message;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public static OrderStatus findStatus(Byte status){
        switch (status){
            case 0:
                return no_confirm;
                
            case 1:
                return has_confirm;
                
            case 2:
                return has_recieved;
                
            case 3:
                return cancled;
                
            case 4:
                return completed;
                
            case 5:
                return discard;
            default:
                return cancled;
        }
    }
}