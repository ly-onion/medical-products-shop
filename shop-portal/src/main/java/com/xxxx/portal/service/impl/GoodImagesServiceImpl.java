package com.xxxx.portal.service.impl;

import com.xxxx.portal.mapper.GoodsImagesMapper;
import com.xxxx.portal.pojo.GoodsImages;
import com.xxxx.portal.pojo.GoodsImagesExample;
import com.xxxx.portal.service.GoodImagesService;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/9 21:38
 */
@Service
public class GoodImagesServiceImpl implements GoodImagesService {

    @Resource
    private GoodsImagesMapper imagesMapper;

    /**
     * 通过goodsId找到商品所有展示图
     *
     * @param goodsId
     * @return
     */
    @Override
    public List<GoodsImages> findGoodImageByGoodsId(Integer goodsId) {
        GoodsImagesExample example = new GoodsImagesExample();
        example.createCriteria().andGoodsIdEqualTo(goodsId);
        List<GoodsImages> goodsImagesList = imagesMapper.selectByExample(example);
        if (!CollectionUtils.isEmpty(goodsImagesList) && goodsImagesList.size() > 0) {
            return goodsImagesList;
        } else {
            return new ArrayList<>();
        }
    }
}
