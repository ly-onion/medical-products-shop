package com.xxxx.portal.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.pojo.Goods;
import com.xxxx.rpc.service.GoodsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @RequestMapping("/good")
    public String toGoodDetail(Integer goodsId, Model model) {
        Goods good = goodsService.selectGoodsById(goodsId);
        model.addAttribute("good", good);
        return "goods/good-detail";
    }
}
