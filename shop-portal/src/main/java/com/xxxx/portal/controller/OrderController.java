package com.xxxx.portal.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * 订单Controller
 *
 * @author zhoubin
 * @since 1.0.0
 */
@Controller
@RequestMapping("order")
public class OrderController {

	/**
	 * 跳转订单系统
	 * @return
	 */
	@RequestMapping("toPreOrder")
	public String toPreOrder(HttpServletRequest request){
		String orderUrl = (String) request.getSession().getServletContext().getAttribute("orderUrl");
		return "redirect:"+orderUrl+"order/preOrder";
	}

	/**
	 * 支付异步通知回调页面
	 * @param model
	 * @return
	 */
	@RequestMapping("callback")
	public String callback(Model model){
		model.addAttribute("result", "success");
		System.out.println("异步通知成功！==");
		return "order/callback";
	}

}