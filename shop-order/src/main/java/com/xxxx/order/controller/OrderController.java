package com.xxxx.order.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.order.config.AlipayConfig;
import com.xxxx.common.pojo.Order;
import com.xxxx.rpc.service.OrderService;
import com.xxxx.rpc.service.CartService;
import com.xxxx.rpc.vo.CartResult;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 订单Controller
 *
 * @author zhoubin
 * @since 1.0.0
 */
@Controller
@RequestMapping("order")
public class OrderController {

	@Reference(interfaceClass = CartService.class)
	private CartService cartService;
	@Reference(interfaceClass = OrderService.class)
	private OrderService orderService;

	/**
	 * 跳转到预订单页面
	 * @return
	 */
	@RequestMapping("preOrder")
	public String preOrder(Model model, HttpServletRequest request){
		Admin admin = (Admin) request.getSession().getAttribute("user");
		model.addAttribute("cartResult",cartService.getCartList(admin));
		return "order/preOrder";
	}

	/**
	 * 跳转到订单提交页面
	 * @return
	 */
	@RequestMapping("submitOrder")
	public String submitOrder(Model model,HttpServletRequest request){
		Admin admin = (Admin) request.getSession().getAttribute("user");
		CartResult cartResult = cartService.getCartList(admin);
		//1.存入订单信息
		BaseResult baseResult = orderService.orderSave(admin, cartResult);
		//2.清除购物车信息
		cartService.clearCart(admin);
		//总价
		model.addAttribute("totalPrice",cartResult.getTotalPrice());
		//订单编号
		model.addAttribute("orderSn",baseResult.getMessage());
		//3.页面跳转
		return "order/submitOrder";
	}

	/**
	 * 去付款
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("payment")
	public String payment(HttpServletRequest request,Model model,String orderSn) {
		try {
			//获得初始化的AlipayClient
			AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id,
					AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key,
					AlipayConfig.sign_type);

			//设置请求参数
			AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
			alipayRequest.setReturnUrl(AlipayConfig.return_url);
			alipayRequest.setNotifyUrl(AlipayConfig.notify_url);

			Order order = orderService.selectOrderByOrderSn(orderSn);

			//商户订单号，商户网站订单系统中唯一订单号，必填
			String out_trade_no = orderSn;
			//付款金额，必填
			String total_amount = String.valueOf(order.getTotalAmount());
			//订单名称，必填
			String subject = "用户为"+order.getUserId()+"的订单";
			//商品描述，可空
			String body = "";

			alipayRequest.setBizContent("{\"out_trade_no\":\"" + out_trade_no + "\","
					+ "\"total_amount\":\"" + total_amount + "\","
					+ "\"subject\":\"" + subject + "\","
					+ "\"body\":\"" + body + "\","
					+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

			//若想给BizContent增加其他可选请求参数，以增加自定义超时时间参数timeout_express来举例说明
			//alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","
			//		+ "\"total_amount\":\""+ total_amount +"\","
			//		+ "\"subject\":\""+ subject +"\","
			//		+ "\"body\":\""+ body +"\","
			//		+ "\"timeout_express\":\"10m\","
			//		+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
			//请求参数可查阅【电脑网站支付的API文档-alipay.trade.page.pay-请求参数】章节

			//请求
			String result = alipayClient.pageExecute(alipayRequest).getBody();
			//输出
			System.out.println(result);
			model.addAttribute("result",result);
			return "order/payment";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}


	/**
	 * 跳转到我的订单页面(同步通知)
	 *
	 * @return
	 */
	@RequestMapping("myOrder")
	public String myOrder(HttpServletRequest request, Model model) {
		Admin admin = (Admin) request.getSession().getAttribute("user");
		List<Order> orderList = orderService.selectOrderByUserId(admin);
		model.addAttribute("orderList", orderList);

		return "order/myOrder";
	}

	/**
	 * 支付宝跳转回调页面(异步通知)
	 * @param model
	 * @return
	 */
	@RequestMapping("callback")
	public String callback(Model model){
		model.addAttribute("result", "success");
		System.out.println("异步通知成功！============");
		return "order/callback";
	}

}