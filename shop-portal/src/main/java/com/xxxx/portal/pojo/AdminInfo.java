package com.xxxx.portal.pojo;

import com.xxxx.common.util.TimeExchange;

import java.io.Serializable;

/**
 * @author zhoubin 
 * @since 1.0.0
 */
public class AdminInfo implements Serializable {
    /**
     * 用户ID
     */
    private Integer adminId;

    /**
     * 收货地址
     */
    private String address;

    /**
     * 身高
     */
    private Integer height;

    /**
     * 体重
     */
    private Integer weight;

    /**
     * 性别
     */
    private String sex;

    /**
     * 
     */
    private Integer birthday;

    private String strBirthday;

    /**
     * t_admin_info
     */
    private static final long serialVersionUID = 1L;

    public String getStrBirthday() {
        return strBirthday;
    }

    public void setStrBirthday(String strBirthday) {
        this.strBirthday = strBirthday;
        setBirthday();
    }
    public void setStrBirthday() {
        this.strBirthday = TimeExchange.timestampToString(this.birthday);
    }

    public Integer getAdminId() {
        return adminId;
    }

    public void setAdminId(Integer adminId) {
        this.adminId = adminId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public Integer getHeight() {
        return height;
    }

    public void setHeight(Integer height) {
        this.height = height;
    }

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public Integer getBirthday() {
        return birthday;
    }

    public void setBirthday(Integer birthday) {
        this.birthday = birthday;
        setStrBirthday();
    }
    public void setBirthday(){
        this.birthday=TimeExchange.StringToTimestamp(this.strBirthday);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", adminId=").append(adminId);
        sb.append(", address=").append(address);
        sb.append(", height=").append(height);
        sb.append(", weight=").append(weight);
        sb.append(", sex=").append(sex);
        sb.append(", birthday=").append(birthday);
        sb.append("]");
        return sb.toString();
    }
}