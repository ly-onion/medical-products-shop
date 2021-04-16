package com.xxxx.manager.service;

import com.xxxx.common.result.BaseResult;
import com.xxxx.manager.pojo.Goods;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/15 18:31
 */
public interface GoodsService {

    /**
     * 商品新增-保存
     * @param goods
     * @return
     */
    BaseResult saveGoods(Goods goods);
}
