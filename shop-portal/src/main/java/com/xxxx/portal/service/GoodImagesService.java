package com.xxxx.portal.service;

import com.xxxx.portal.pojo.GoodsImages;

import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/9 21:35
 */
public interface GoodImagesService {

    /**
     * 通过goodsId找到商品所有展示图
     * @param goodsId
     * @return
     */
    List<GoodsImages> findGoodImageByGoodsId(Integer goodsId);
}
