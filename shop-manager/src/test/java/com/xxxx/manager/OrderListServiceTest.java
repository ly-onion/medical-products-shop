package com.xxxx.manager;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.rpc.service.OrderService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/3 19:04
 */
@SpringBootTest
public class OrderListServiceTest {

    @Reference(interfaceClass = OrderService.class)
    private OrderService orderService;

    @Test
    public void testSelectAllOrders(){
        Admin admin = new Admin();
        admin.setAdminId((short) 7);
        BaseResult baseResult = orderService.selectAllOrders(null, 1);
        System.out.println(baseResult.getPageInfo().getList());
    }
}
