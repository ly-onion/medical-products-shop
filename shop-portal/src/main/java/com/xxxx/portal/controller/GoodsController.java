package com.xxxx.portal.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.pojo.Goods;
import com.xxxx.portal.pojo.GoodsImages;
import com.xxxx.portal.service.GoodImagesService;
import com.xxxx.rpc.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/3 16:28
 */
@RequestMapping("goods")
@Controller
public class GoodsController {

    @Reference(interfaceClass = GoodsService.class)
    private GoodsService goodsService;
    @Autowired
    private GoodImagesService goodImagesService;

    @RequestMapping("/good")
    public String toGoodDetail(Integer goodsId, Model model) {
        Goods good = goodsService.selectGoodsById(goodsId);
        List<GoodsImages> imgList = goodImagesService.findGoodImageByGoodsId(goodsId);
        model.addAttribute("good", good);
        model.addAttribute("imgList", imgList);
        return "goods/good-detail";
    }
}
