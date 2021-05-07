package com.xxxx.manager.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.enums.RoleEnum;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.common.util.Md5Util;
import com.xxxx.common.util.TimeExchange;
import com.xxxx.manager.vo.AdminVo;
import com.xxxx.sso.service.UserService;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/4 19:00
 */
@Controller
@RequestMapping("admin")
public class AdminController {

    @Reference(interfaceClass = UserService.class)
    private UserService userService;

    /**
     * 管理系统用户列表
     *
     * @param model
     * @return
     */
    @RequestMapping("list/{role}")
    public String adminList(@PathVariable("role") String role, Model model) {
        List<Admin> adminList = userService.selectAllUser(role);
        List<AdminVo> adminVoList = new ArrayList<>();
        for (Admin admin : adminList) {
            AdminVo adminVo = new AdminVo();
            BeanUtils.copyProperties(admin, adminVo);
            String roleVo = RoleEnum.findMessage(admin.getRoleId()).getMessage();
            adminVo.setRole(roleVo);
            adminVo.setAddTime(TimeExchange.timestampToString(admin.getAddTime()));
            adminVo.setLastLogin(TimeExchange.timestampToString(admin.getLastLogin()));
            adminVoList.add(adminVo);
        }
        model.addAttribute("adminList", adminVoList);
        return "admin/admin-list";
    }

    @RequestMapping("add/{id}")
    public String goodsAdd(@PathVariable("id") Short adminId, Model model) {
        if (adminId != -1) {
            Admin admin = userService.selectAdminByAdminId(adminId);
            AdminVo adminVo = new AdminVo();
            BeanUtils.copyProperties(admin, adminVo);
            String roleVo = RoleEnum.findMessage(admin.getRoleId()).getMessage();
            adminVo.setRole(roleVo);
            adminVo.setAddTime(TimeExchange.timestampToString(admin.getAddTime()));
            adminVo.setLastLogin(TimeExchange.timestampToString(admin.getLastLogin()));
            model.addAttribute("admin", admin);
            model.addAttribute("adminVo", adminVo);
        }
        return "admin/admin-add";
    }


    @RequestMapping("save")
    @ResponseBody
    public BaseResult saveAdmin(Admin admin) {
        System.out.println("============admin = " + admin);
        if (admin.getAdminId() == null) {
            return userService.saveUser(admin);
        } else {
            return userService.updateAdmin(admin);
        }
    }

    @RequestMapping(value = "list/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public BaseResult deleteGoods(@PathVariable("id") Short adminId) {
        return userService.deleteAdmin(adminId);
    }
}
