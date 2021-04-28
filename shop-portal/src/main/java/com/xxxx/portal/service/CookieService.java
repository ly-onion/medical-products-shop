package com.xxxx.portal.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/25 18:26
 */
public interface CookieService {

    /**
     * 设置cookie
     * @param request
     * @param response
     * @param ticket
     * @return
     */
    Boolean setCookie(HttpServletRequest request, HttpServletResponse response, String ticket);

    /**
     * 获取cookie
     * @param request
     * @return
     */
    String getCookie(HttpServletRequest request);

    /**
     * 删除cookie
     * @param request
     * @param response
     * @return
     */
    Boolean deleteCookie(HttpServletRequest request, HttpServletResponse response);
}
