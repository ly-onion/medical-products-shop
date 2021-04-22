package com.xxxx.portal;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/22 14:53
 */
@SpringBootApplication
@MapperScan("con.xxxx.portal.mapper")
public class PortalApplication {
    public static void main(String[] args) {
        SpringApplication.run(PortalApplication.class, args);
    }
}
