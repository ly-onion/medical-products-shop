package com.xxxx.order.config;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {

	public static String public_address = "http://e73zex.natappfree.cc";
//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
	public static String app_id = "2021000117648159";

	// 商户私钥，您的PKCS8格式RSA2私钥
	public static String merchant_private_key = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC4WGZrX+oAW4CQIFpxyeFGXHmLKlRl3PRSU5aeM04uJ8LD1nhJdeiVUMA4Qt/AAZ3bESjjx9rsfEczyKSCQMc3lruAwYySMdJHxvg9cimV5dlmR0ftK0JBgfAVHJqRmp4G6oN8N/NINwdfgMRC54Z5OLqIS/jXNpPEPugaaDP3ajPcsd0Ah7r/ZfpHFRGQKjgwjUy3+sEvY0me8H3PrUAnQVBRQeNWo9TDd/GE2D7wFJMVo8p4D4j5dQJKEXwv/wuXHgzjK8ajfeg7dLm++Pu/Md/vNHYiVE8eOFK+/CmSla49qm3iZTYPqS7/+nE6sA1bH1wBDOr9hRSf3KlMra9pAgMBAAECggEBAKWO7ty8FUIg64OFKvVKo8E3SAlOCOI64EoXvAt0dGBLYUXUlc8Tz8BZ92gP1zdvvD+EV77KPLlqm9/L8MLyPniULO1j5kVd7UZ9UXCN2P9AoFCU7+n2kdiXQ/ER8VeXDxmTAGdNMHbIxRxmXtzfZgv0gMHryR4va+IxxO4Ca7lk5smHhBhudyaXfKRC2gok1d0xavLkg/qkqlFt0yDf+6YdDecfINFHFRQcKkv4vYFhhoIaNS4LhyrAMVgiR0jGJVhYXF2S/s4UPTCEjUIylSpnnqT5bUDPSkEHMCeP0jRIZ/GduEHxT5HgpNisT+O6+brmjRi81XMQWaRh4uwHRMkCgYEA6gkw4zWwrtPNlLmdc1Vl2u0kUOOkd8z4ZiUEQxJEa89yiM6kZDBVsnUHpg90cKYaE873JY1DXYhh03ekpTGijbhsQ5Is/cZSkwQYayn1u/JqNJhc2DFcWe42C+CZwqae3cIhcVeeRNvp1nOCoXf2b3MXfpiitx1WWIWvCTRlpocCgYEAyaVfSVpMxYfV76GiLjWfR+YQtx/I86kRNRj/vRk9LRSAUujL92s8WhZXvGnH8O+peeAsD2Y7XMxNmHo4TQzvNy40J1xKCYSpfwmLaZj9IMIIjMKPedk33S1bsA10SbpO4Y7z2CfzZU0czcK8RPyjev+K6fIyc1fl0UfpEEstho8CgYBUPMyo63lV5AyaHJlMmw9XVoX8y4M2T8OU2HwJPDj+aSO7lE1ddnxSCIehQOzTYyX9vT/99zOpJd64Q9cyUoRE6H2ncKTbDxhHrHCxmd/GL4IEvlakxleMUw6HBeeyRVDnVum8pyHjfRhUxSzeu5QrF0z8lynyKRAcOrn+4So5XwKBgA/H8noiKAn5hIO5iaDGL44H8lzyjt6K577ZEwKwm/oQNa7Ha1cUvGdsgjdLrAsuJnxUT/5wiMrNbnE1d3yIO5x88DX4Yg72o/E+RPvhrkXHCbZCb8ogdt/HcfqIQwaWHyBF+M186u6Np2hvCh74Cq9QmoWOn+YpBeJoF1RgHdL/AoGBAMM4wZAf5Uu3q88c0oOUbF5yntEIuum75dLuXyNW989xtMrwZ53f7RyiUtIFbGyDf1tLjFIdch9em21jtINgVlApuXczTquENllcPNsGbVfuO7dnhWr440PQkmjhiabAd5zLiCD9QQGg2mpmocKN/J+54ti/RHKB4NASep5ZosKq";

	// 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
	public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzTEgNVPVj7WgdyewUIFBuSDwUJFsnPPArc1ITp8igKclGcEcZmbYoiWU7wHMHiR/PKmFzV5pWAJO5ma6IEPs3Z/ZeqKkIUR1I3aRBwMVXcx6/KwYGOYOx1EfftCZHUOEKHVxVH6eg1ooYQH8MMsDmH794uBP1ma5feku/ZUPlBGcFyS6APKaAarMGYFxHtZozlTJ+oxxrhuyiqT9OSfTWffDDLjhvEVm1s1vor5qhYXw/9J9aVTkkzvNE6TMg0ZxRuzinvJXYQPqNgmIU7sAz3RT0TfhOAnazXal6IJawLBwGXTSZ7OSZxgeEmJAIW0pUUDTmqBorgiLrD7j3RZG+wIDAQAB";

	// 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String notify_url = public_address + "/shop-portal/order/callback";

	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String return_url = "http://localhost:9092/shop-order/order/myOrder";

	// 签名方式
	public static String sign_type = "RSA2";

	// 字符编码格式
	public static String charset = "utf-8";

	// 支付宝网关
	public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";

	// 支付宝网关
	public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

	/**
	 * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
	 * @param sWord 要写入日志里的文本内容
	 */
	public static void logResult(String sWord) {
		FileWriter writer = null;
		try {
			writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
			writer.write(sWord);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (writer != null) {
				try {
					writer.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}