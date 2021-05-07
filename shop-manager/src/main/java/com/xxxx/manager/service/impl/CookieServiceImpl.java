package com.xxxx.manager.service.impl;

import com.xxxx.common.util.CookieUtil;
import com.xxxx.manager.service.CookieService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/25 18:28
 */
@Service
public class CookieServiceImpl implements CookieService {

    /**
     * 设置Cookie
     *
     * @param request
     * @param response
     * @param ticket
     * @return
     */
    @Override
    public Boolean setCookie(HttpServletRequest request, HttpServletResponse response, String ticket) {
        try {
            CookieUtil.setCookie(request, response, "managerTicket", ticket);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 获取cookie
     *
     * @param request
     * @return
     */
    @Override
    public String getCookie(HttpServletRequest request) {
        return CookieUtil.getCookieValue(request, "userTicket");
    }

    /**
     * 删除cookie
     *
     * @param request
     * @param response
     * @return
     */
    @Override
    public Boolean deleteCookie(HttpServletRequest request, HttpServletResponse response) {
        try {
            CookieUtil.deleteCookie(request, response, "userTicket");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
