package com.xxxx.manager.controller;

import com.xxxx.manager.service.GoodsCategoryService;
import com.xxxx.manager.service.GoodsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:页面跳转
 * @USER: 洋葱
 * @DATE: 2021/4/7 18:52
 */
@Controller
public class PageController {

    @RequestMapping("/{page}")
    public String page(@PathVariable String page){
        System.out.println(page);
        return page;
    }

    /*
    * 跳转首页
    * */
    @RequestMapping("/")
    public String index(){
        return "index";
    }

    @RequestMapping("index/Admin/System/login_task")
    @ResponseBody
    public String toCorrect(){
        return "index";
    }
}
