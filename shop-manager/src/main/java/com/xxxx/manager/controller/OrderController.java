package com.xxxx.manager.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.rpc.service.OrderService;
import com.xxxx.sso.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/3 17:20
 */
@RequestMapping("orders")
@Controller
public class OrderController {

    @Reference(interfaceClass = OrderService.class)
    private OrderService orderService;
    @Reference(interfaceClass = UserService.class)
    private UserService userService;

    @RequestMapping("orderList")
    public String orderList() {
        return "order/order-List";
    }


    @RequestMapping("listForPage")
    @ResponseBody
    public BaseResult selectOrderListByPage(String userName, Integer pageNum){
        Admin admin = userService.selectUserByUserName(userName);
        return orderService.selectAllOrders(admin, pageNum);
    }

}
