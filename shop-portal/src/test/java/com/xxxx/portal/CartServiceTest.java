package com.xxxx.portal;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.pojo.Admin;
import com.xxxx.rpc.service.CartService;
import com.xxxx.rpc.vo.CartVo;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/28 22:44
 */
@SpringBootTest
public class CartServiceTest {

    @Reference(interfaceClass = CartService.class)
    private CartService cartService;

    @Test
    public void testAddCart() {
        Admin admin = new Admin();
        admin.setAdminId((short) 1);
        CartVo cartVo = new CartVo();
        cartVo.setGoodsId(12345);
        cartVo.setGoodsName("JAVA insprie");
        cartVo.setGoodsNum(10);
        cartVo.setMarketPrice(new BigDecimal(100));
        cartVo.setAddTime(new Date());
        cartService.addCart(cartVo, admin);
    }

    @Test
    public void testGetCartNum() {
        Admin admin = new Admin();
        admin.setAdminId((short) 1);
        Integer cartNum = cartService.getCartNum(admin);
        System.out.println(cartNum);

    }


}
