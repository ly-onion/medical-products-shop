package com.xxxx.manager.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xxxx.common.result.BaseResult;
import com.xxxx.common.util.JsonUtil;
import com.xxxx.manager.mapper.GoodsMapper;
import com.xxxx.common.pojo.Goods;
import com.xxxx.common.pojo.GoodsExample;
import com.xxxx.manager.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
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
 * @DATE: 2021/4/15 18:31
 */
@Service
public class GoodsServiceImpl implements GoodsService {

    @Resource
    private GoodsMapper goodsMapper;
    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    /**
     * 商品新增-保存
     *
     * @param goods
     * @return
     */
    @Override
    public BaseResult saveGoods(Goods goods) {
        if (null != goods.getGoodsId()) {
            return BaseResult.error();
        }
        redisTemplate.delete(redisTemplate.keys("goods*"));
        //html文本转义
        if (!StringUtils.isEmpty(goods.getGoodsContent())) {
            goods.setGoodsContent(HtmlUtils.htmlEscape(goods.getGoodsContent(), "UTF-8"));
        }
        int result = goodsMapper.insertSelective(goods);
        BaseResult baseResult = BaseResult.error();
        if (0 < result) {
            baseResult = BaseResult.success();
            baseResult.setMessage(String.valueOf(goods.getGoodsId()));
        } else {
            baseResult = BaseResult.error();
        }
        return baseResult;
    }

    /**
     * 商品列表-分页查询
     *
     * @param goods
     * @param pageNum
     * @param pageSize
     * @return
     */
    @Override
    public BaseResult selectGoodsListByPage(Goods goods, Integer pageNum, Integer pageSize) {
        //定义RedisKey数组
        String[] goodsKeyArr = new String[]{
                "goods:pageNum_" + pageNum + ":PageSize_" + pageSize + ":",
                "catId_:",
                "brandId_:",
                "goodsName_:"
        };
        //构建分页对象
        Page<Object> page = PageHelper.startPage(pageNum, pageSize);
        //创建查询对象
        GoodsExample example = new GoodsExample();
        GoodsExample.Criteria criteria = example.createCriteria();
        //设置查询条件
        //分类参数
        if (null != goods.getCatId() && 0 != goods.getCatId()) {
            criteria.andCatIdEqualTo(goods.getCatId());
            goodsKeyArr[1] = "catId_" + goods.getCatId() + ":";
        }
        //品牌参数
        if (null != goods.getBrandId() && 0 != goods.getBrandId()) {
            criteria.andBrandIdEqualTo(goods.getBrandId());
            goodsKeyArr[2] = "brandtId_" + goods.getBrandId() + ":";
        }
        //关键词参数
        if (!StringUtils.isEmpty(goods.getGoodsName())) {
            criteria.andGoodsNameLike("%" + goods.getGoodsName() + "%");
            goodsKeyArr[3] = "goodsName_" + goods.getGoodsName() + ":";
        }
        //拼接完整的RedisKey
        String goodsListKey = Arrays.stream(goodsKeyArr).collect(Collectors.joining());
        ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
        //查询缓存，如果缓存中存在数据，直接返回
        String pageInfoGoodsJson = valueOperations.get(goodsListKey);
        if (!StringUtils.isEmpty(pageInfoGoodsJson)) {
            return BaseResult.success(JsonUtil.jsonStr2Object(pageInfoGoodsJson, PageInfo.class));
        }
        //判断查询结果是否为空
        List<Goods> list = goodsMapper.selectByExample(example);
        if (!CollectionUtils.isEmpty(list)) {
            PageInfo<Goods> pageInfo = new PageInfo<>(list);
            //放入redis缓存
            valueOperations.set(goodsListKey, JsonUtil.object2JsonStr(pageInfo));
            return BaseResult.success(pageInfo);
        } else {
            //如果没有数据，将空数据放入缓存，设置失效时间60s
            valueOperations.set(goodsListKey, JsonUtil.object2JsonStr(new PageInfo<>(new ArrayList<Goods>())), 60, TimeUnit.SECONDS);
        }
        return BaseResult.error();
    }

    /**
     * 删除商品
     *
     * @param goodsId
     */
    @Override
    public BaseResult deleteGoods(Integer goodsId) {
        String goodsName = goodsMapper.selectByPrimaryKey(goodsId).getGoodsName();
        redisTemplate.delete(redisTemplate.keys("goods:pageNum_*:PageSize_*:catId_*:brandId_*:goodsName_" + goodsName + ":"));
        goodsMapper.deleteByPrimaryKey(goodsId);
        return BaseResult.success();
    }

    /**
     * 通过ID查找goods
     *
     * @param goodsId
     * @return
     */
    @Override
    public Goods selectGoodsByGoodsId(Integer goodsId) {
        Goods goods = goodsMapper.selectByPrimaryKey(goodsId);
        if (goods != null) {
            return goods;
        }else {
            return new Goods();
        }
    }

    /**
     * 通过ID更新goods
     *
     * @param goods
     * @return
     */
    @Override
    public BaseResult updateGoodsByGoodsId(Goods goods) {
        goodsMapper.updateByPrimaryKeySelective(goods);
        redisTemplate.delete(redisTemplate.keys("goods*"));
        return BaseResult.success();
    }

}
