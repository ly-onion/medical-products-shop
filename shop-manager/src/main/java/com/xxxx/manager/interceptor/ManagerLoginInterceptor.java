package com.xxxx.manager.interceptor;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.util.CookieUtil;
import com.xxxx.common.util.JsonUtil;
import com.xxxx.sso.service.SSOService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.concurrent.TimeUnit;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION: 后台登录拦截器
 * @USER: 洋葱
 * @DATE: 2021/4/25 18:50
 */
@Component
public class ManagerLoginInterceptor implements HandlerInterceptor {

    @Reference(interfaceClass = SSOService.class)
    private SSOService ssoService;
    @Autowired
    private RedisTemplate<String, String> redisTemplate;
    @Value("${user.ticket}")
    private String usetTicket;

    /**
     * 请求处理的方法之前执行
     * @param request
     * @param response
     * @param handler
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取用户票据
        String ticket = CookieUtil.getCookieValue(request, "userTicket");
        if (!StringUtils.isEmpty(ticket)) {
            //如果票据存在，进行验证
            Admin admin = ssoService.validate(ticket);
            //将用户信息存入session，用于页面返显
            request.getSession().setAttribute("user", admin);
            //重新设置失效时间
            ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
            valueOperations.set(usetTicket+":"+ticket, JsonUtil.object2JsonStr(admin), 30, TimeUnit.MINUTES);
            return true;
        }
        //票据不存在或者用户验证失败,重定向到登录页面
        response.sendRedirect(request.getContextPath()+"/login");
        return false;
    }

    /**
     * 请求处理的方法之后执行
     * @param request
     * @param response
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    /**
     * 处理后执行清理工作
     * @param request
     * @param response
     * @param handler
     * @param ex
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
