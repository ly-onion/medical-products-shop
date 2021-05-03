package com.xxxx.sso.service;

import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;

/**
 * 用户服务
 */
public interface UserService {

	/**
	 * 用户注册
	 * @param admin
	 * @return
	 */
	BaseResult saveUser(Admin admin);

	/**
	 * 用户信息修改
	 * @param admin
	 * @return
	 */
	BaseResult updateUser(Admin admin);

	/**
	 * 通过用户名查找用户
	 * @param userName
	 * @return
	 */
	Admin selectUserByUserName(String userName);
}
