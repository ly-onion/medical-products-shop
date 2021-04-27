package com.xxxx.rpc.service;

import com.xxxx.common.result.ShopPageInfo;
import com.xxxx.rpc.vo.GoodsVo;

import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/24 19:01
 */
public interface SearchService {

    /**
     * 搜索
     * @param searchStr
     * @param pageNum
     * @param pageSize
     * @return
     */
//    List<GoodsVo> doSearch(String searchStr, Integer pageNum, Integer pageSize);
    ShopPageInfo<GoodsVo> doSearch(String searchStr, Integer pageNum, Integer pageSize);
}
