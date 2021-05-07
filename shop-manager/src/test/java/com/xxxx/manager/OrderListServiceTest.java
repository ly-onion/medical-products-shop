package com.xxxx.manager;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.enums.OrderStatus;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.pojo.Order;
import com.xxxx.common.result.BaseResult;
import com.xxxx.manager.mapper.AdvertisementMapper;
import com.xxxx.manager.service.AdManagerService;
import com.xxxx.rpc.service.OrderService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/3 19:04
 */
@SpringBootTest
public class OrderListServiceTest {

//    @Reference(interfaceClass = OrderService.class)
//    private OrderService orderService;
//    @Reference(interfaceClass = AdManagerService.class)
//    private AdManagerService adManagerService;
    @Autowired
    private RedisTemplate<String, String> redisTemplate;
    @Autowired
    private AdvertisementMapper advertisementMapper;

    @Test
    public void testSelectAllOrders() {
        System.out.println(advertisementMapper.selectByPrimaryKey(61));
    }

//
//    @Test
//    public void testEnumParams() {
//        Order order = new Order();
//        updateOrder(order, (byte) 4);
//        System.out.println("order = " + order);
//
//    }
//
//    public void updateOrder(Order order, Byte byteStatus) {
//        OrderStatus orderStatus = OrderStatus.findStatus(byteStatus);
//        System.out.println("orderStatus.getMessage() = " + orderStatus.getMessage());
//        order.setOrderStatus(orderStatus.getStatus().byteValue());
//    }
}
