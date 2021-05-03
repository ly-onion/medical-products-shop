package com.xxxx.rpc.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.xxxx.common.pojo.Goods;
import com.xxxx.common.pojo.GoodsExample;
import com.xxxx.rpc.mapper.GoodsMapper;
import com.xxxx.rpc.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/3 16:22
 */
@Service(interfaceClass = GoodsService.class)
@Component
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private GoodsMapper goodsMapper;

    /**
     * 通过goodsId查找商品
     *
     * @param goodsId
     * @return
     */
    @Override
    public Goods selectGoodsById(Integer goodsId) {
        GoodsExample example = new GoodsExample();
        example.createCriteria().andGoodsIdEqualTo(goodsId);
        List<Goods> goods = goodsMapper.selectByExample(example);
        if (CollectionUtils.isEmpty(goods)&&goods.size()>1){
            return null;
        }
        return goods.get(0);
    }
}
