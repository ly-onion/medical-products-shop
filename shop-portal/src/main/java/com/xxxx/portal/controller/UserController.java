package com.xxxx.portal.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.portal.service.CookieService;
import com.xxxx.sso.service.UserService;
import com.xxxx.rpc.service.SendMessageService;
import com.xxxx.sso.service.SSOService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/25 18:29
 */
@Controller
@RequestMapping("user")
public class UserController {

    @Reference(interfaceClass = SSOService.class)
    private SSOService ssoService;
    @Autowired
    private CookieService cookieService;
    @Reference(interfaceClass = UserService.class)
    private UserService userService;
    @Reference(interfaceClass = SendMessageService.class)
    private SendMessageService sendMessageService;

    @RequestMapping("login")
    @ResponseBody
    public BaseResult login(Admin admin, HttpServletRequest request, HttpServletResponse response) {
        //登录成功并生成票据
        String ticket = ssoService.login(admin);
        //如果票据生成成功，写入cookie
        if (!StringUtils.isEmpty(ticket)) {
            boolean result = cookieService.setCookie(request, response, ticket);
            //将用户信息存入session中，用于页面返显
            request.getSession().setAttribute("user", admin);
            return result ? BaseResult.success() : BaseResult.error();
        }
        return BaseResult.error();
    }

    /**
     * 用户退出
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        //清楚redis
        String ticket = cookieService.getCookie(request);
        ssoService.logout(ticket);
        //清楚session
        request.getSession().removeAttribute("user");
        //清楚cookie
        cookieService.deleteCookie(request, response);
        return "login";
    }

    /**
     * 用户注册
     *
     * @param admin
     * @return
     */
    @RequestMapping("register")
    @ResponseBody
    public BaseResult register(Admin admin) {
        BaseResult baseResult = userService.saveUser(admin);
        if (200 == baseResult.getCode()) {
            BaseResult baseResult1 = sendMessageService.sendMessage(admin);
            if (200 == baseResult1.getCode()) {
                return BaseResult.success();
            }
        }
        return BaseResult.error();
    }
}
