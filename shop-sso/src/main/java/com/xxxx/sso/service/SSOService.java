package com.xxxx.sso.service;

import com.xxxx.common.pojo.Admin;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/25 16:36
 */
public interface SSOService {

    /**
     * 登录认证方法 返回票据ticket
     * @param admin
     * @return
     */
    String login(Admin admin);

    /**
     * 验证票据ticket返回用户信息
     * @param ticket
     * @return
     */
    Admin validate(String ticket);

    /**
     * 用户登出
     * @param tikcet
     */
    void logout(String tikcet);
}
