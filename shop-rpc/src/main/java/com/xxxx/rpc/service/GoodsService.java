package com.xxxx.rpc.service;

import com.xxxx.common.pojo.Goods;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/3 16:21
 */
public interface GoodsService {

    /**
     * 通过goodsId查找商品
     * @param goodsId
     * @return
     */
    Goods selectGoodsById(Integer goodsId);
}
