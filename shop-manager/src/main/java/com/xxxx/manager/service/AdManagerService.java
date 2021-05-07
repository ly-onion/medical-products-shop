package com.xxxx.manager.service;


import com.xxxx.common.pojo.Advertisement;
import com.xxxx.common.result.BaseResult;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/5 15:22
 */
public interface AdManagerService {

    BaseResult saveAd(Advertisement advertisement);

    BaseResult selectAdListForPage(String adName, Integer pageNum);

    Advertisement selectAdByAdId(Integer adId);

    BaseResult deleteAd(Integer adId);

    BaseResult updateAd(Advertisement advertisement);

    Integer checkAmount();
}
