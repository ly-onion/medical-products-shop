package com.xxxx.manager.pojo;

import java.io.Serializable;

/**
 * @author zhoubin 
 * @since 1.0.0
 */
public class AdvertisementImages implements Serializable {
    /**
     * 图片id
     */
    private Integer imgId;

    /**
     * 广告id
     */
    private Integer adId;

    /**
     * 图片地址
     */
    private String adImageUrl;

    /**
     * t_ad_images
     */
    private static final long serialVersionUID = 1L;

    public Integer getImgId() {
        return imgId;
    }

    public void setImgId(Integer imgId) {
        this.imgId = imgId;
    }

    public Integer getAdId() {
        return adId;
    }

    public void setAdId(Integer adId) {
        this.adId = adId;
    }

    public String getAdImageUrl() {
        return adImageUrl;
    }

    public void setAdImageUrl(String adImageUrl) {
        this.adImageUrl = adImageUrl == null ? null : adImageUrl.trim();
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", imgId=").append(imgId);
        sb.append(", adId=").append(adId);
        sb.append(", adImageUrl=").append(adImageUrl);
        sb.append("]");
        return sb.toString();
    }
}