package com.xxxx.rpc.service;

import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.rpc.vo.CartResult;
import com.xxxx.rpc.vo.CartVo;

/**
 * 购物车服务
 */
public interface CartService {
    /**
     * 加入购物车
     * @param cartVo
     * @param admin
     * @return
     */
    BaseResult addCart(CartVo cartVo, Admin admin);

    /**
     * 查询购物车数量
     * @param admin
     * @return
     */
    Integer getCartNum(Admin admin);

    /**
     * 获取购物车列表
     * @param admin
     * @return
     */
    CartResult getCartList(Admin admin);

    /**
     * 清除购物车
     * @param admin
     * @return
     */
    BaseResult clearCart(Admin admin);

    /**
     * 删除购物车中一件商品
     * @param cartVo
     * @return
     */
    BaseResult deleteCartGood(CartVo cartVo, Admin admin);
}
