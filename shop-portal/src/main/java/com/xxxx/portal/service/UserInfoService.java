package com.xxxx.portal.service;

import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.portal.pojo.AdminInfo;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/8 14:08
 */
public interface UserInfoService {

    AdminInfo findUserInfoByAdminId(Integer adminId);

    BaseResult updateUserInfo(AdminInfo adminInfo);
}
