package com.xxxx.sso.service;

import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;

import java.util.List;

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

	/**
	 * 查询所有管理员用户
	 * @return
	 */
	List<Admin> selectAllUser(String role);

	/**
	 * 通过ID查找admin
	 * @param adminId
	 * @return
	 */
	Admin selectAdminByAdminId(Short adminId);

	/**
	 * 新增管理员
	 * @param admin
	 * @return
	 */
	BaseResult saveAdmin(Admin admin);

	/**
	 * 根据ID更新管理员信息
	 * @param admin
	 * @return
	 */
	BaseResult updateAdmin(Admin admin);

	/**
	 * 删除管理员
	 * @param adminId
	 * @return
	 */
	BaseResult deleteAdmin(Short adminId);
}
