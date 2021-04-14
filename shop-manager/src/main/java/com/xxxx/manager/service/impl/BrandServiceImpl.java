package com.xxxx.manager.service.impl;

import com.xxxx.manager.mapper.BrandMapper;
import com.xxxx.manager.pojo.Brand;
import com.xxxx.manager.pojo.BrandExample;
import com.xxxx.manager.service.BrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:品牌实现类
 * @USER: 洋葱
 * @DATE: 2021/4/14 17:09
 */
@Service
public class BrandServiceImpl implements BrandService {

    @Autowired
    private BrandMapper brandMapper;

    /**
     * 查询所有品牌
     * @return
     */
    @Override
    public List<Brand> selectBrandList() {
        return brandMapper.selectByExample(new BrandExample());
    }
}
