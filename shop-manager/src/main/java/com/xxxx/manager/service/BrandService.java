package com.xxxx.manager.service;

import com.xxxx.manager.pojo.Brand;

import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION: 品牌service
 * @USER: 洋葱
 * @DATE: 2021/4/14 17:07
 */
public interface BrandService {

    /**
     * 查询所有品牌
     * @return
     */
    List<Brand> selectBrandList();
}
