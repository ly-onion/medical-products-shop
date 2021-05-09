package com.xxxx.portal.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.common.util.Md5Util;
import com.xxxx.portal.pojo.AdminInfo;
import com.xxxx.portal.service.UserInfoService;
import com.xxxx.sso.service.SSOService;
import com.xxxx.sso.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
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
    @Autowired
    private UserInfoService userInfoService;

    @RequestMapping("/user")
    public String toUserInfoPage(Model model, HttpServletRequest request) {
        Admin admin = (Admin) request.getSession().getAttribute("user");
        AdminInfo userInfo = userInfoService.findUserInfoByAdminId(Integer.valueOf(admin.getAdminId()));
        model.addAttribute("userInfo", userInfo);
        return "user/userInfo";
    }

    @RequestMapping("/info")
    @ResponseBody
    public BaseResult userInfo(AdminInfo adminInfo) {
        System.out.println("adminInfo = " + adminInfo);
        return userInfoService.updateUserInfo(adminInfo);
    }

    @RequestMapping("/modifyPsw")
    public String toMpswPage() {
        return "user/modifyPsw";
    }

    @RequestMapping("/savePsw")
    @ResponseBody
    public BaseResult savePsw(HttpServletRequest request, String oldPassword, String newPassword) {
        Admin admin = (Admin) request.getSession().getAttribute("user");
        System.out.println("admin.getPassword() = " + admin.getPassword());
        System.out.println("加密后：" + Md5Util.getMd5WithSalt(oldPassword, admin.getEcSalt()));
        BaseResult baseResult = userService.modifyPsw(admin, oldPassword, newPassword);
        request.getSession().setAttribute("user", admin);
        return baseResult;
    }
}
