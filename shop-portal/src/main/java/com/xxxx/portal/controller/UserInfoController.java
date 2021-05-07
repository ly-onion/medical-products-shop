package com.xxxx.portal.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.portal.pojo.AdminInfo;
import com.xxxx.sso.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/3 16:32
 */
@Controller
@RequestMapping("userInfo")
public class UserInfoController {

    @Reference(interfaceClass = UserService.class)
    private UserService userService;

    @RequestMapping("/user")
    public String toUserInfoPage(Model model, HttpServletRequest request){
        Admin admin = (Admin) request.getSession().getAttribute("user");
        model.addAttribute("admin",admin);
        return "user/userInfo";
    }

    @RequestMapping("/info")
    @ResponseBody
    public BaseResult userInfo(AdminInfo adminInfo){
        System.out.println("adminInfo = " + adminInfo);
        return BaseResult.success();
    }

//    @RequestMapping("")
}
