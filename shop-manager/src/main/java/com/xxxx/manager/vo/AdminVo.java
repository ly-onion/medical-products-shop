package com.xxxx.manager.vo;

import java.io.Serializable;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/5 12:32
 */
public class AdminVo implements Serializable {

    /**
     * 用户id
     */
    private Short adminId;

    /**
     * 用户名
     */
    private String userName;

    /**
     * email
     */
    private String email;

    /**
     * 添加时间
     */
    private String addTime;

    /**
     * 密码
     */
    private String password;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * 最后登录时间
     */
    private String lastLogin;

    /**
     * 角色id
     */
    private String role;

    /**
     * t_admin
     */
    private static final long serialVersionUID = 1L;

    public Short getAdminId() {
        return adminId;
    }

    public void setAdminId(Short adminId) {
        this.adminId = adminId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddTime() {
        return addTime;
    }

    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public String getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(String lastLogin) {
        this.lastLogin = lastLogin;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "AdminVo{" +
                "adminId=" + adminId +
                ", userName='" + userName + '\'' +
                ", email='" + email + '\'' +
                ", addTime=" + addTime +
                ", lastLogin=" + lastLogin +
                ", role='" + role + '\'' +
                '}';
    }
}
