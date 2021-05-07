package com.xxxx.manager.service.impl;

import com.alibaba.dubbo.common.utils.CollectionUtils;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xxxx.common.pojo.*;
import com.xxxx.common.result.BaseResult;
import com.xxxx.common.util.JsonUtil;
import com.xxxx.manager.mapper.AdvertisementMapper;
import com.xxxx.manager.service.AdManagerService;
import com.xxxx.rpc.vo.OrderVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.util.HtmlUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/5 15:25
 */
@Service
public class AdManagerServiceImpl implements AdManagerService {

    @Resource
    private AdvertisementMapper adMapper;
    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    /**
     * 商品新增-保存
     *
     * @param advertisement
     * @return
     */
    @Override
    public BaseResult saveAd(Advertisement advertisement) {
        if (null != advertisement.getAdId()) {
            return BaseResult.error();
        }
        redisTemplate.delete(redisTemplate.keys("advertisements*"));
        int result = adMapper.insertSelective(advertisement);
        BaseResult baseResult = BaseResult.error();
        if (0 < result) {
            baseResult = BaseResult.success();
            baseResult.setMessage(String.valueOf(advertisement.getAdId()));
        } else {
            baseResult = BaseResult.error();
        }
        return baseResult;
    }

    @Override
    public BaseResult selectAdListForPage(String adName, Integer pageNum) {
        //定义RedisKey数组
        String[] adsKey = new String[]{
                "advertisements:pageNum_" + pageNum + ":",
                "adName:"
        };
        //构建分页对象
        Page<Object> page = PageHelper.startPage(pageNum, 10);
        //创建查询对象
        AdvertisementExample example = new AdvertisementExample();
        example.setOrderByClause("enabled DESC");
        if (adName.length() == 0) {
            List<Advertisement> advertisementList = adMapper.selectByExample(example);
            if (!CollectionUtils.isEmpty(advertisementList)) {
                PageInfo<Advertisement> pageInfo = new PageInfo<>(advertisementList);
                return BaseResult.success(pageInfo);
            } else {
                return BaseResult.error();
            }
        } else {
            adsKey[1] = "adName_" + adName + ":";
            //拼接完整的RedisKey
            String ordersListKey = Arrays.stream(adsKey).collect(Collectors.joining());
            ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
            //查询缓存，如果缓存中存在数据，直接返回
            String pageInfoOrdersJson = valueOperations.get(ordersListKey);
            if (!StringUtils.isEmpty(pageInfoOrdersJson)) {
                return BaseResult.success(JsonUtil.jsonStr2Object(pageInfoOrdersJson, PageInfo.class));
            }
            example.createCriteria().andAdNameEqualTo(adName);
            List<Advertisement> advertisementList = adMapper.selectByExample(example);
            if (!CollectionUtils.isEmpty(advertisementList)) {
                PageInfo<Advertisement> pageInfo = new PageInfo<>(advertisementList);
                //放入redis缓存
                valueOperations.set(ordersListKey, JsonUtil.object2JsonStr(pageInfo));
                return BaseResult.success(pageInfo);
            } else {
                //如果没有数据，将空数据放入缓存，设置失效时间60s
                valueOperations.set(ordersListKey,
                        JsonUtil.object2JsonStr(new PageInfo<>(new ArrayList<OrderVo>())), 60, TimeUnit.SECONDS);
                return BaseResult.error();
            }
        }
    }

    /**
     * 删除商品
     *
     * @param adId
     */
    @Override
    public BaseResult deleteAd(Integer adId) {
        String adName = adMapper.selectByPrimaryKey(adId).getAdName();
        redisTemplate.delete(redisTemplate.keys("advertisements:pageNum_*:adName_" + adName + ":"));
        adMapper.deleteByPrimaryKey(adId);
        return BaseResult.success();
    }

    /**
     * 通过ID查找goods
     *
     * @param adId
     * @return
     */
    @Override
    public Advertisement selectAdByAdId(Integer adId) {
        Advertisement advertisement = adMapper.selectByPrimaryKey(adId);
        if (advertisement != null) {
            return advertisement;
        }else {
            return new Advertisement();
        }
    }

    /**
     * 通过ID更新goods
     *
     * @param advertisement
     * @return
     */
    @Override
    public BaseResult updateAd(Advertisement advertisement) {

        adMapper.updateByPrimaryKeySelective(advertisement);
        redisTemplate.delete(redisTemplate.keys("advertisements*"));
        return BaseResult.success();
    }

    @Override
    public Integer checkAmount() {
        AdvertisementExample example = new AdvertisementExample();
        example.createCriteria().andEnabledEqualTo((byte) 1);
        List<Advertisement> advertisementList = adMapper.selectByExample(example);
        return advertisementList.size();
    }
}
