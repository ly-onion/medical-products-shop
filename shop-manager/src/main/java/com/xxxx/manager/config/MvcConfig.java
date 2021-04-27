package com.xxxx.manager.config;

import com.xxxx.manager.interceptor.ManagerLoginInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION: MVC配置类
 * @USER: 洋葱
 * @DATE: 2021/4/25 19:10
 */
@Configuration
@EnableWebMvc
public class MvcConfig implements WebMvcConfigurer {

    @Autowired
    private ManagerLoginInterceptor loginInterceptor;

    /**
     * 添加自定义的拦截器
     * @param registry
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/static/**")
                .excludePathPatterns("/login/**")
                .excludePathPatterns("/user/login/**")
                .excludePathPatterns("/user/logout/**");
    }

    /**
     * 放行静态资源
     * @param registry
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**").addResourceLocations("classpath:/static/");
    }
}
