package com.xxxx.sso.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.pojo.AdminExample;
import com.xxxx.common.util.JsonUtil;
import com.xxxx.common.util.Md5Util;
import com.xxxx.common.util.UUIDUtil;
import com.xxxx.sso.mapper.AdminMapper;
import com.xxxx.sso.service.SSOService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/25 16:48
 */
@Service(interfaceClass = SSOService.class)
@Component
public class SSOServiceImpl implements SSOService {

    @Autowired
    private AdminMapper adminMapper;
    @Autowired
    private RedisTemplate<String, String> redisTemplate;
    @Value("${user.ticket}")
    private String userTicket;

    /**
     * 登录认证方法返回票据ticket
     *
     * @param admin
     * @return
     */
    @Override
    public String login(Admin admin) {
        //判断参数合法性
        //判断参数是否为空
        if (StringUtils.isEmpty(admin.getUserName().trim())) {
            System.out.println("用户名为空");
            return null;
        }
        //判断密码是否为空
        if (StringUtils.isEmpty(admin.getPassword().trim())) {
            System.out.println("密码为空");
            return null;
        }
        //去数据库验证用户信息，先判断用户名是否存在
        AdminExample example = new AdminExample();
        example.createCriteria().andUserNameEqualTo(admin.getUserName());
        List<Admin> list = adminMapper.selectByExample(example);
        if (CollectionUtils.isEmpty(list) || list.size() > 1) {
            System.out.println("用户名或密码错误");
            return null;
        }
        Admin a = list.get(0);
        //判断密码，需要先进性加密
        if (!a.getPassword().equals(Md5Util.getMd5WithSalt(admin.getPassword(), a.getEcSalt()))) {
            System.out.println("用户名或密码错误");
            return null;
        }
        //用户名和密码一致，登录成功返回票据信息
        //生成票据信息存入redis，页面借助cookie存储票据ticket
        ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
        String ticket = UUIDUtil.getUUID();
        //设置三十分钟过期
        valueOperations.set(userTicket + ":" + ticket, JsonUtil.object2JsonStr(a), 30, TimeUnit.SECONDS);
        return ticket;
    }

    /**
     * 验证票据ticket返回用户信息
     *
     * @param ticket
     * @return
     */
    @Override
    public Admin validate(String ticket) {
        if (StringUtils.isEmpty(ticket)) {
            System.out.println("票据信息不存在");
            return null;
        }
        ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
        String adminJson = valueOperations.get(userTicket + ":" + ticket);
        if (StringUtils.isEmpty(adminJson)) {
            System.out.println("票据信息对应用户不存在");
            return null;
        }
        return JsonUtil.jsonStr2Object(adminJson, Admin.class);
    }

    /**
     * 用户退出
     * @param tikcet
     */
    @Override
    public void logout(String tikcet) {
        redisTemplate.delete(userTicket+":"+tikcet);
    }
}
