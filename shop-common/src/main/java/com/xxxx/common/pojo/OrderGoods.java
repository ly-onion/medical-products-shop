package com.xxxx.common.pojo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * @author zhoubin 
 * @since 1.0.0
 */
public class OrderGoods implements Serializable {
    /**
     * 表id自增
     */
    private Integer recId;

    /**
     * 订单id
     */
    private Integer orderId;

    /**
     * 商品id
     */
    private Integer goodsId;

    /**
     * 商品货号
     */
    private String goodsSn;

    /**
     * 购买数量
     */
    private Short goodsNum;

    /**
     * 市场价
     */
    private BigDecimal marketPrice;

    /**
     * 本店价
     */
    private BigDecimal goodsPrice;

    /**
     * 商品成本价
     */
    private BigDecimal costPrice;

    /**
     * 商品规格key
     */
    private String specKey;

    /**
     * 0未发货，1已发货，2已换货，3已退货
     */
    private Byte isSend;

    /**
     * 发货单ID
     */
    private Integer deliveryId;

    /**
     * sku
     */
    private String sku;

    /**
     * t_order_goods
     */
    private static final long serialVersionUID = 1L;

    public Integer getRecId() {
        return recId;
    }

    public void setRecId(Integer recId) {
        this.recId = recId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public String getGoodsSn() {
        return goodsSn;
    }

    public void setGoodsSn(String goodsSn) {
        this.goodsSn = goodsSn == null ? null : goodsSn.trim();
    }

    public Short getGoodsNum() {
        return goodsNum;
    }

    public void setGoodsNum(Short goodsNum) {
        this.goodsNum = goodsNum;
    }

    public BigDecimal getMarketPrice() {
        return marketPrice;
    }

    public void setMarketPrice(BigDecimal marketPrice) {
        this.marketPrice = marketPrice;
    }

    public BigDecimal getGoodsPrice() {
        return goodsPrice;
    }

    public void setGoodsPrice(BigDecimal goodsPrice) {
        this.goodsPrice = goodsPrice;
    }

    public BigDecimal getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(BigDecimal costPrice) {
        this.costPrice = costPrice;
    }

    public String getSpecKey() {
        return specKey;
    }

    public void setSpecKey(String specKey) {
        this.specKey = specKey == null ? null : specKey.trim();
    }

    public Byte getIsSend() {
        return isSend;
    }

    public void setIsSend(Byte isSend) {
        this.isSend = isSend;
    }

    public Integer getDeliveryId() {
        return deliveryId;
    }

    public void setDeliveryId(Integer deliveryId) {
        this.deliveryId = deliveryId;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku == null ? null : sku.trim();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", recId=").append(recId);
        sb.append(", orderId=").append(orderId);
        sb.append(", goodsId=").append(goodsId);
        sb.append(", goodsSn=").append(goodsSn);
        sb.append(", goodsNum=").append(goodsNum);
        sb.append(", marketPrice=").append(marketPrice);
        sb.append(", goodsPrice=").append(goodsPrice);
        sb.append(", costPrice=").append(costPrice);
        sb.append(", specKey=").append(specKey);
        sb.append(", isSend=").append(isSend);
        sb.append(", deliveryId=").append(deliveryId);
        sb.append(", sku=").append(sku);
        sb.append("]");
        return sb.toString();
    }
}