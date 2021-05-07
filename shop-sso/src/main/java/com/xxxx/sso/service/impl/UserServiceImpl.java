package com.xxxx.sso.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.github.pagehelper.Page;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.pojo.AdminExample;
import com.xxxx.common.result.BaseResult;
import com.xxxx.common.util.Md5Util;
import com.xxxx.common.util.RandomUtil;
import com.xxxx.sso.mapper.AdminMapper;
import com.xxxx.sso.service.UserService;
//import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.util.HtmlUtils;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
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

    @Resource
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
        example.createCriteria().andUserNameEqualTo(admin.getUserName());
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
        } else {
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
        } else {
            return null;
        }
    }

    /**
     * 查询所有管理员用户
     *
     * @return
     */
    @Override
    public List<Admin> selectAllUser(String role) {
        AdminExample example = new AdminExample();
        if (role.equalsIgnoreCase("managerUser")) {
            example.createCriteria().andRoleIdBetween((short) 0, (short) 2);
        }else if (role.equalsIgnoreCase("portalUser")){
            example.createCriteria().andRoleIdEqualTo((short)3);
        }
        return adminMapper.selectByExample(example);
    }

    /**
     * 通过ID查找admin
     *
     * @param adminId
     * @return
     */
    @Override
    public Admin selectAdminByAdminId(Short adminId) {
        return adminMapper.selectByPrimaryKey(adminId);
    }

    /**
     * 新增管理员
     *
     * @param admin
     * @return
     */
    @Override
    public BaseResult saveAdmin(Admin admin) {
        if (null != admin.getAdminId()){
            return BaseResult.error();
        }
        int result = adminMapper.insertSelective(admin);
        if (0 < result) {
            return BaseResult.success();
        } else {
            return BaseResult.error();
        }
    }

    /**
     * 根据ID更新管理员信息
     *
     * @param admin
     * @return
     */
    @Override
    public BaseResult updateAdmin(Admin admin) {
        adminMapper.updateByPrimaryKeySelective(admin);
        return BaseResult.success();
    }

    /**
     * 删除管理员
     *
     * @param adminId
     * @return
     */
    @Override
    public BaseResult deleteAdmin(Short adminId) {
        adminMapper.deleteByPrimaryKey(adminId);
        return BaseResult.success();
    }
}