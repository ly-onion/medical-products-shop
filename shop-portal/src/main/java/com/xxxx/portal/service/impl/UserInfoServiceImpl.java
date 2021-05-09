package com.xxxx.portal.service.impl;

import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.portal.mapper.AdminInfoMapper;
import com.xxxx.portal.mapper.AdminMapper;
import com.xxxx.portal.pojo.AdminInfo;
import com.xxxx.portal.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/8 14:09
 */
@Service
public class UserInfoServiceImpl implements UserInfoService {

    @Resource
    private AdminInfoMapper adminInfoMapper;

    /**
     * 用id查找用户信息
     *
     * @param adminId
     * @return
     */
    @Override
    public AdminInfo findUserInfoByAdminId(Integer adminId) {
        return adminInfoMapper.selectByPrimaryKey(adminId);
    }

    @Override
    public BaseResult updateUserInfo(AdminInfo adminInfo) {
        int result = adminInfoMapper.updateByPrimaryKeySelective(adminInfo);
        return result > 0 ? BaseResult.success() : BaseResult.error();
    }
}
