package com.xxxx.portal.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.pojo.Goods;
import com.xxxx.rpc.service.GoodsService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/3 16:28
 */
@RequestMapping("goods")
public class GoodsController {

    @Reference(interfaceClass = GoodsService.class)
    private GoodsService goodsService;

    @RequestMapping("getGood")
    @ResponseBody
    public Goods getGood(Integer goodsId){
        return goodsService.selectGoodsById(goodsId);
    }
}
