package com.xxxx.rpc.service;

import com.xxxx.rpc.vo.GoodsCategoryVo;

import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/10 17:35
 */
public interface GoodsCategoryService {
    /*
    * 商品分类-列表
    * */
    List<GoodsCategoryVo> selectCategoryListForView();
}
