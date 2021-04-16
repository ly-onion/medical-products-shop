package com.xxxx.manager.service.impl;

import com.xxxx.common.result.BaseResult;
import com.xxxx.manager.mapper.GoodsMapper;
import com.xxxx.manager.pojo.Goods;
import com.xxxx.manager.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/15 18:31
 */
@Service
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private GoodsMapper goodsMapper;

    @Override
    public BaseResult saveGoods(Goods goods) {
        if (null != goods.getGoodsId()) {

            return BaseResult.error();
        }
        int result = goodsMapper.insertSelective(goods);
        BaseResult baseResult = BaseResult.error();
        if (0 < result) {
            baseResult = BaseResult.success();
            baseResult.setMessage(String.valueOf(goods.getGoodsId()));
        }else {
            baseResult = BaseResult.error();
        }
        return baseResult;
    }
}
