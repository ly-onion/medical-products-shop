package com.xxxx.portal.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.rpc.service.CartService;
import com.xxxx.rpc.vo.CartResult;
import com.xxxx.rpc.vo.CartVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/29 17:07
 */
@Controller
@RequestMapping("cart")
public class CartController {

    @Reference(interfaceClass = CartService.class)
    private CartService cartService;

    /**
     * 加入购物车
     *
     * @param cartVo
     * @param request
     * @return
     */
    @RequestMapping("addCart")
    @ResponseBody
    public BaseResult addCart(CartVo cartVo, HttpServletRequest request) {
        cartVo.setAddTime(new Date());
        Admin admin = (Admin) request.getSession().getAttribute("user");
        return cartService.addCart(cartVo, admin);
    }

    /**
     * 获取购物车数量
     *
     * @param request
     * @return
     */
    @RequestMapping("getCartNum")
    @ResponseBody
    public Integer getCartNum(HttpServletRequest request) {
        Admin admin = (Admin) request.getSession().getAttribute("user");
        return cartService.getCartNum(admin);
    }

    /**
     * 跳转至购物车列表页面
     *
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("getCartList")
    public String getCartList(HttpServletRequest request, Model model) {
        Admin admin = (Admin) request.getSession().getAttribute("user");
        CartResult cartResult = cartService.getCartList(admin);
        model.addAttribute("cartResult", null == cartResult ? new CartResult() : cartResult);
        return "cart/list";
    }

    /**
     * 清空购物车
     *
     * @param request
     * @return
     */
    @RequestMapping("clearCart")
    @ResponseBody
    public BaseResult clearCart(HttpServletRequest request) {
        Admin admin = (Admin) request.getSession().getAttribute("user");
        return cartService.clearCart(admin);
    }

    /**
     * 删除购物车中指定商品
     * @param request
     * @param cartVo
     * @return
     */
    @RequestMapping("deleteCartGood")
    @ResponseBody
    public BaseResult deleteCartGood(HttpServletRequest request, CartVo cartVo) {
        Admin admin = (Admin) request.getSession().getAttribute("user");
        return cartService.deleteCartGood(cartVo, admin);
    }


}
