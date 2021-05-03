package com.xxxx.rpc.service;

import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;

/**
 * 短信发送服务
 */
public interface SendMessageService {

	/**
	 * 发送短信
	 * @param admin
	 * @return
	 */
	BaseResult sendMessage(Admin admin);
}
