package com.xxxx.manager.service.impl;

import com.xxxx.common.result.BaseResult;
import com.xxxx.manager.mapper.AdvertisementImagesMapper;
import com.xxxx.manager.mapper.GoodsImagesMapper;
import com.xxxx.manager.pojo.AdvertisementImages;
import com.xxxx.manager.pojo.GoodsImages;
import com.xxxx.manager.service.ImagesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/16 16:42
 */
@Service
public class ImagesServiceImpl implements ImagesService {

    @Autowired
    private GoodsImagesMapper goodsImagesMapper;
    @Autowired
    private AdvertisementImagesMapper advertisementImagesMapper;

    @Override
    public BaseResult saveGoodsImages(GoodsImages goodsImages) {
        int result = goodsImagesMapper.insertSelective(goodsImages);
        return result > 0 ? BaseResult.success() : BaseResult.error();
    }

    @Override
    public BaseResult saveAdImages(AdvertisementImages advertisementImages) {
        int result = advertisementImagesMapper.insertSelective(advertisementImages);
        return result > 0 ? BaseResult.success() : BaseResult.error();
    }
}
