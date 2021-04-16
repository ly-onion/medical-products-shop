package com.xxxx.manager.service;

import com.xxxx.common.result.BaseResult;
import com.xxxx.manager.pojo.GoodsImages;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/16 16:41
 */
public interface GoodsImagesService {

    /**
     * 商品-新增-相册保存
     *
     * @return
     */
    BaseResult saveGoodsImages(GoodsImages goodsImages);
}
