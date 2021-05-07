package com.xxxx.common.pojo;

import com.xxxx.common.util.TimeExchange;

import java.io.Serializable;

/**
 * @author zhoubin
 * @since 1.0.0
 */
public class Advertisement implements Serializable {
    /**
     * 广告id
     */
    private Integer adId;

    /**
     * 广告位置ID
     */
    private Integer pid;

    /**
     * 广告位置
     */
    private String adPosition;

    public String getAdPosition() {
        return adPosition;
    }

    public void setAdPosition() {
        this.adPosition = String.valueOf(this.pid) + "号轮播位置";
    }

    public void setAdPosition(String adPosition) {
        this.adPosition = adPosition;
    }

    /**
     * 广告名称
     */
    private String adName;

    /**
     * 链接地址
     */
    private String adLink;

    /**
     * 投放时间
     */
    private Integer startTime;

    /**
     * 结束时间
     */
    private Integer endTime;

    /**
     * 添加人
     */
    private String linkMan;

    /**
     * 添加人联系电话
     */
    private String linkPhone;

    /**
     * 点击量
     */
    private Integer clickCount;

    /**
     * 是否显示
     */
    private Byte enabled;

    /**
     * 图片地址
     */
    private String adCode;

    /**
     * 投放时间
     */
    private String begin;

    /**
     * 结束时间
     */
    private String end;

    /**
     * 是否展示
     */
    private String isShow;

    public void setIsShow(){
        if (this.enabled ==1) {
            this.isShow = "是";
        }else {
            this.isShow = "否";
        }
    }

    public String getIsShow() {
        return isShow;
    }

    public void setIsShow(String isShow) {
        this.isShow = isShow;
        setEnabled();
    }

    /**
     * t_ad
     */
    private static final long serialVersionUID = 1L;

    public Integer getAdId() {
        return adId;
    }

    public void setAdId(Integer adId) {
        this.adId = adId;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
        setAdPosition();
    }

    public String getAdName() {
        return adName;
    }

    public void setAdName(String adName) {
        this.adName = adName == null ? null : adName.trim();
    }

    public String getAdLink() {
        return adLink;
    }

    public void setAdLink(String adLink) {
        this.adLink = adLink == null ? null : adLink.trim();
    }

    public Integer getStartTime() {
        return startTime;
    }

    public void setStartTime(Integer startTime) {
        this.startTime = startTime;
        setBegin();
    }

    public Integer getEndTime() {
        return endTime;
    }

    public void setEndTime(Integer endTime) {
        this.endTime = endTime;
        setEnd();
    }

    public String getLinkMan() {
        return linkMan;
    }

    public void setLinkMan(String linkMan) {
        this.linkMan = linkMan == null ? null : linkMan.trim();
    }

    public String getLinkPhone() {
        return linkPhone;
    }

    public void setLinkPhone(String linkPhone) {
        this.linkPhone = linkPhone == null ? null : linkPhone.trim();
    }

    public Integer getClickCount() {
        return clickCount;
    }

    public void setClickCount(Integer clickCount) {
        this.clickCount = clickCount;
    }

    public Byte getEnabled() {
        return enabled;
    }

    public void setEnabled(Byte enabled) {
        this.enabled = enabled;
        setIsShow();
    }

    public void setEnabled(){
        if (this.isShow.equalsIgnoreCase("是")) {
            this.enabled = 1;
        }else {
            this.enabled = 0;
        }
    }

    public String getAdCode() {
        return adCode;
    }

    public void setAdCode(String adCode) {
        this.adCode = adCode == null ? null : adCode.trim();
    }

    public String getBegin() {
        return begin;
    }

    public void setBegin() {
        this.begin = TimeExchange.timestampToString(this.startTime);
    }

    public String getEnd() {
        return end;
    }

    public void setEndTime(){
        this.endTime = TimeExchange.StringToTimestamp(this.end);
    }

    public void setStartTime(){
        this.startTime = TimeExchange.StringToTimestamp(this.begin);
    }

    public void setBegin(String begin) {
        this.begin = begin;
        setStartTime();
    }

    public void setEnd(String end) {
        this.end = end;
        setEndTime();
    }

    public void setEnd() {
        this.end = TimeExchange.timestampToString(this.endTime);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", adId=").append(adId);
        sb.append(", pid=").append(pid);
        sb.append(", adName=").append(adName);
        sb.append(", adLink=").append(adLink);
        sb.append(", startTime=").append(startTime);
        sb.append(", endTime=").append(endTime);
        sb.append(", linkMan=").append(linkMan);
        sb.append(", linkPhone=").append(linkPhone);
        sb.append(", clickCount=").append(clickCount);
        sb.append(", enabled=").append(enabled);
        sb.append(", adCode=").append(adCode);
        sb.append(", adCode=").append(begin);
        sb.append(", adCode=").append(end);
        sb.append("]");
        return sb.toString();
    }
}