package com.xxxx.sso.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.pojo.AdminExample;
import com.xxxx.common.result.BaseResult;
import com.xxxx.common.util.Md5Util;
import com.xxxx.common.util.RandomUtil;
import com.xxxx.sso.mapper.AdminMapper;
import com.xxxx.sso.service.UserService;
//import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Date;
import java.util.List;

/**
 * 用户服务实现类
 *
 * @author zhoubin
 * @since 1.0.0
 */
@Service(interfaceClass = UserService.class)
@Component
public class UserServiceImpl implements UserService {

    @Autowired
    private AdminMapper adminMapper;
//	@Autowired
//	private RabbitTemplate rabbitTemplate;

    /**
     * 用户注册
     *
     * @param admin
     * @return
     */
    @Override
    public BaseResult saveUser(Admin admin) {
        AdminExample example = new AdminExample();
        example.createCriteria().andAdminIdEqualTo(admin.getAdminId());
        List<Admin> admins = adminMapper.selectByExample(example);
        if (CollectionUtils.isEmpty(admins)) {
            //生成salt并存入用户信息
            String salt = RandomUtil.getRandom1();
            admin.setEcSalt(salt);
            //根据salt加密免密
            String password = Md5Util.getMd5WithSalt(admin.getPassword(), salt);
            admin.setPassword(password);
            //设置注册时间
            admin.setAddTime((int) LocalDateTime.now().toEpochSecond(ZoneOffset.of("+8")));
            int result = adminMapper.insertSelective(admin);

            return result > 0 ? BaseResult.success() : BaseResult.error();
        }else {
            return BaseResult.error();
        }


//		if (result>0){
//			rabbitTemplate.convertAndSend("smsExchange","register.sms",admin.getEmail());
//			System.out.println("发送的消息"+admin.getEmail());
//			return BaseResult.success();
//		}
//		return BaseResult.error();
    }

    /**
     * 用户信息修改
     *
     * @param admin
     * @return
     */
    @Override
    public BaseResult updateUser(Admin admin) {
        AdminExample example = new AdminExample();
        example.createCriteria().andAdminIdEqualTo(admin.getAdminId());
        List<Admin> admins = adminMapper.selectByExample(example);
        if (!CollectionUtils.isEmpty(admins)) {
            admin.setLastLogin((int) LocalDateTime.now().toEpochSecond(ZoneOffset.of("+8")));
            int result = adminMapper.updateByPrimaryKeySelective(admin);
            return result > 0 ? BaseResult.success() : BaseResult.error();
        } else {
            return BaseResult.error();
        }
    }

    /**
     * 通过用户名查找用户
     *
     * @param userName
     * @return
     */
    @Override
    public Admin selectUserByUserName(String userName) {
        AdminExample example = new AdminExample();
        example.createCriteria().andUserNameEqualTo(userName);
        List<Admin> admins = adminMapper.selectByExample(example);
        if (!CollectionUtils.isEmpty(admins)) {
            return admins.get(0);
        }else {
            return null;
        }
    }


}