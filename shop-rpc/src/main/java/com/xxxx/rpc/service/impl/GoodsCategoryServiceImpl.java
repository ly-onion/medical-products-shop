package com.xxxx.rpc.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.xxxx.common.util.JsonUtil;
import com.xxxx.rpc.mapper.GoodsCategoryMapperRPC;
import com.xxxx.rpc.pojo.GoodsCategory;
import com.xxxx.rpc.pojo.GoodsCategoryExample;
import com.xxxx.rpc.service.GoodsCategoryService;
import com.xxxx.rpc.vo.GoodsCategoryVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/10 17:37
 */
@Service(interfaceClass = GoodsCategoryService.class)
@Component
public class GoodsCategoryServiceImpl implements GoodsCategoryService {

    @Autowired
    private GoodsCategoryMapperRPC goodsCategoryMapperRPC;
    @Autowired
    private RedisTemplate<String, String> redisTemplate;
    @Value("${goods.category.list.key}")
    private String goodsCategoryListKey;


    /*
     * 商品分类-列表
     * */
    @Override
    public List<GoodsCategoryVo> selectCategoryListForView() {
        ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
        //查询redis缓存是否有数据，有数据直接返回,没有数据去数据库查询
        String gcvListJson = valueOperations.get(goodsCategoryListKey);
        if (!StringUtils.isEmpty(gcvListJson)) {
            return JsonUtil.jsonToList(gcvListJson, GoodsCategoryVo.class);
        }
        //===================================JDK8新特性
        GoodsCategoryExample example = new GoodsCategoryExample();
        //查询所有商品分类
        List<GoodsCategory> list = goodsCategoryMapperRPC.selectByExample(example);
        //将GoodsCategory对象转成GoodsCategoryVo对象
        List<GoodsCategoryVo> gcvList = list.stream().map(e -> {
            GoodsCategoryVo gcv = new GoodsCategoryVo();
            BeanUtils.copyProperties(e, gcv);
            return gcv;
        }).collect(Collectors.toList());
        //将List<GoodsCategoryVo>转成Map<parentId, List<GoodsCategoryVo>>
        //按parentId分组，key就是parentId, 值就是parentId对应的List<GoodsCategoryVo>
        Map<Short, List<GoodsCategoryVo>> map = gcvList.stream().collect(Collectors.groupingBy(GoodsCategoryVo::getParentId));
        //循环，给children赋值
        gcvList.forEach(e -> e.setChildren(map.getOrDefault(e.getId(), new ArrayList<>())));
        //拦截器返回level为1的List，顶级分类
        List<GoodsCategoryVo> gcvList01 = gcvList.stream().filter(e -> 1 == e.getLevel()).collect(Collectors.toList());
        //放入redis缓存
        valueOperations.set(goodsCategoryListKey, JsonUtil.object2JsonStr(gcvList01));
        //==================================JDK8新特性
        return gcvList01;
    }
}
