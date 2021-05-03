package com.xxxx.rpc.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xxxx.common.pojo.Goods;
import com.xxxx.common.pojo.GoodsExample;
import com.xxxx.common.result.ShopPageInfo;
import com.xxxx.rpc.mapper.GoodsMapper;
import com.xxxx.rpc.service.SearchService;
import com.xxxx.rpc.vo.GoodsVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/24 19:02
 */
@Service(interfaceClass = SearchService.class)
@Component
public class SearchServiceImpl implements SearchService {

    @Autowired
    private GoodsMapper goodsMapper;

    @Override
    public ShopPageInfo<GoodsVo> doSearch(String searchStr, Integer pageNum, Integer pageSize) {
        //构建分页对象
        PageHelper.startPage(pageNum, pageSize);
        ShopPageInfo<GoodsVo> shopPageInfo;
        //创建查询对象
        GoodsExample example = new GoodsExample();
        example.createCriteria().andGoodsNameLike("%" + searchStr + "%");
        List<Goods> goodsList = goodsMapper.selectByExample(example);
        Page<GoodsVo> goodsVoList = new Page<>();
        BeanUtils.copyProperties(goodsList, goodsVoList);
//        goodsVoList.setTotal(((Page)goodsList).getTotal());
        for (Goods goods : goodsList) {
            GoodsVo goodsVo = new GoodsVo();
            BeanUtils.copyProperties(goods, goodsVo);
            goodsVoList.add(goodsVo);
        }
        PageInfo<GoodsVo> pageInfo = new PageInfo<>(goodsVoList);
        shopPageInfo = new ShopPageInfo<>(pageNum, pageSize, pageInfo);
        return shopPageInfo;
    }


    /**
     * 搜索
     * @param searchStr
     * @param pageNum
     * @param pageSize
     * @return
     */
//    @Override
//    public BaseResult doSearch(GoodsVo goodsVo, Integer pageNum, Integer pageSize) {
//        //定义RedisKey数组
//        String[] goodsKeyArr = new String[]{
//                "goods:pageNum_"+pageNum+":PageSize_"+pageSize+":",
//                "goodsId_",
//                "goodsName_:",
//                "marketPrice_:",
//                "originalImg_"
//        };
//        //构建分页对象
//        PageHelper.startPage(pageNum, pageSize);
//        //创建查询对象
//        GoodsExample example = new GoodsExample();
//        GoodsExample.Criteria criteria = example.createCriteria();
//        //设置查询条件
//        //分类参数
//        if (null != goodsVo.getGoodsId() && 0 != goodsVo.getGoodsId()) {
//            criteria.andCatIdEqualTo(goodsVo.getGoodsId());
//            goodsKeyArr[1] = "goodsId_"+goodsVo.getGoodsId()+":";
//        }
//        //品牌参数
//        if (null != goods.getBrandId() && 0 != goods.getBrandId()) {
//            criteria.andBrandIdEqualTo(goods.getBrandId());
//            goodsKeyArr[2] = "brandtId_"+goods.getBrandId()+":";
//        }
//        //关键词参数
//        if (!StringUtils.isEmpty(goods.getGoodsName())) {
//            criteria.andGoodsNameLike("%" + goods.getGoodsName() + "%");
//            goodsKeyArr[3] = "goodsName_"+goods.getGoodsName()+":";
//        }
//        //拼接完整的RedisKey
//        String goodsListKey = Arrays.stream(goodsKeyArr).collect(Collectors.joining());
//        ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
//        //查询缓存，如果缓存中存在数据，直接返回
//        String pageInfoGoodsJson = valueOperations.get(goodsListKey);
//        if (!StringUtils.isEmpty(pageInfoGoodsJson)) {
//            return BaseResult.success(JsonUtil.jsonStr2Object(pageInfoGoodsJson, PageInfo.class));
//        }
//        //判断查询结果是否为空
//        List<Goods> list = goodsMapper.selectByExample(example);
//        if (!CollectionUtils.isEmpty(list)) {
//            PageInfo<Goods> pageInfo  = new PageInfo<>(list);
//            //放入redis缓存
//            valueOperations.set(goodsListKey, JsonUtil.object2JsonStr(pageInfo));
//            return BaseResult.success(pageInfo);
//        }else {
//            //如果没有数据，将空数据放入缓存，设置失效时间60s
//            valueOperations.set(goodsListKey, JsonUtil.object2JsonStr(new PageInfo<>(new ArrayList<Goods>())),60, TimeUnit.SECONDS);
//        }
//        return BaseResult.error();
//    }
}
