package com.xxxx.portal.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.result.ShopPageInfo;
import com.xxxx.rpc.service.SearchService;
import com.xxxx.rpc.vo.GoodsVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/25 14:12
 */
@Controller
@RequestMapping("search")
public class SearchController {

    @Reference(interfaceClass = SearchService.class)
    private SearchService searchService;

    /**
     * 跳转搜索页
     * @param searchStr
     * @param model
     * @return
     */
    @RequestMapping("index")
    public String index(String searchStr, Model model){
        model.addAttribute("searchStr", searchStr);
        return "search/doSearch";
    }


    /**
     * 搜索商品
     * @param searchStr
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping("searchGoods")
    @ResponseBody
    public ShopPageInfo<GoodsVo> searchGoods(String searchStr, Integer pageNum, Integer pageSize){
        return searchService.doSearch(searchStr, pageNum, pageSize);
    }
}
