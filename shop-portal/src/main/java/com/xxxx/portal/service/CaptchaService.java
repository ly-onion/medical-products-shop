package com.xxxx.portal.service;

import com.xxxx.common.result.BaseResult;

/**
 * 验证服务
 */
public interface CaptchaService {
	//校验验证码
	BaseResult captcha(String ticket, String randStr);
}
