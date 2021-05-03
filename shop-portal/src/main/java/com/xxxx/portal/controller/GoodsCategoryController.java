package com.xxxx.portal.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.rpc.service.GoodsCategoryService;
import com.xxxx.rpc.service.GoodsService;
import com.xxxx.rpc.vo.GoodsCategoryVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/23 17:34
 */
@Controller
@RequestMapping("goodsCategory")
public class GoodsCategoryController {

    @Reference(interfaceClass = GoodsCategoryService.class)
    private GoodsCategoryService goodsCategoryService;
    /**
     * 查询商品分类-列表
     * @return
     */
    @RequestMapping("list")
    @ResponseBody
    public List<GoodsCategoryVo> categoryList(){
        return goodsCategoryService.selectCategoryListForView();
    }

}
