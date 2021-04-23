package com.xxxx.rpc.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.xxxx.common.util.JsonUtil;
import com.xxxx.rpc.mapper.GoodsCategoryMapper;
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
    private GoodsCategoryMapper goodsCategoryMapper;
    @Autowired
    private RedisTemplate<String, String> redisTemplate;
    @Value("${goods.category.list.key}")
    private String goodsCategoryListKey;


    /*
     * 商品分类-列表
     * */
    @Override
    public List<GoodsCategoryVo> selectCategoryListForView() {
//        GoodsCategoryExample example = new GoodsCategoryExample();
//        example.createCriteria().andParentIdEqualTo((short) 0).andLevelEqualTo((byte) 1);
//        List<GoodsCategory> gcList = goodsCategoryMapper.selectByExample(example);
//        List<GoodsCategoryVo> gcvList = new ArrayList<>();
//        for (GoodsCategory gc01 : gcList) {
//            GoodsCategoryVo gcv01 = new GoodsCategoryVo();
//            //把GoodsCategory对象转成GoodsCategoryVo对象
//            BeanUtils.copyProperties(gc01,gcv01);
//            //清空example
//            example.clear();
//            example.createCriteria().andParentIdEqualTo(gc01.getId()).andLevelEqualTo((byte) 2);
//            //查询二级分类
//            List<GoodsCategory> gcList02 = goodsCategoryMapper.selectByExample(example);
//            List<GoodsCategoryVo> gcvList02 = new ArrayList<>();
//            for (GoodsCategory gc02 : gcList02) {
//                GoodsCategoryVo gcv02 = new GoodsCategoryVo();
//                BeanUtils.copyProperties(gc02,gcv02);
//                //清空example
//                example.clear();
//                example.createCriteria().andParentIdEqualTo(gc02.getId()).andLevelEqualTo((byte) 3);
//                //查询三级分类
//                List<GoodsCategory> gcList03 = goodsCategoryMapper.selectByExample(example);
//                List<GoodsCategoryVo> gcvList03 = new ArrayList<>();
//                for (GoodsCategory gc03 : gcList03) {
//                    GoodsCategoryVo gcv03 = new GoodsCategoryVo();
//                    BeanUtils.copyProperties(gc03,gcv03);
//                    gcvList03.add(gcv03);
//                }
//                //把三级分类List放入二级分类的对象里
//                gcv02.setChildren(gcvList03);
//                gcvList02.add(gcv02);
//            }
//            //把二级分类放入一级分类的对象里
//            gcv01.setChildren(gcvList02);
//            gcvList.add(gcv01);
//        }
//        return gcvList;
        ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
        //查询redis缓存是否有数据，有数据直接返回,没有数据去数据库查询
        String gcvListJson = valueOperations.get(goodsCategoryListKey);
        if (!StringUtils.isEmpty(gcvListJson)) {
            return JsonUtil.jsonToList(gcvListJson, GoodsCategoryVo.class);
        }
        //===================================JDK8新特性
        GoodsCategoryExample example = new GoodsCategoryExample();
        //查询所有商品分类
        List<GoodsCategory> list = goodsCategoryMapper.selectByExample(example);
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
