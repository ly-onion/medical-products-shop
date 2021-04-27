package com.xxxx.portal;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.result.ShopPageInfo;
import com.xxxx.common.util.JsonUtil;
import com.xxxx.rpc.service.SearchService;
import com.xxxx.rpc.vo.GoodsVo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.BeanUtils;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/24 19:40
 */
@SpringBootTest
public class SearchServiceTest {

    @Reference(interfaceClass = SearchService.class)
    private SearchService searchService;

    @Test
    public void testSearch(){
        ShopPageInfo<GoodsVo> goodsVoList = searchService.doSearch("电信", 1, 5);
        System.out.println(JsonUtil.object2JsonStr(goodsVoList));
    }

    @Test
    public void test(){
        User yjj = new User(1, "yjj");
        U syy = new U();
        BeanUtils.copyProperties(yjj , syy);

        System.out.println(syy.name);
    }

    public static class User{
        int age ;
        String name;
        User(int a ,String b){
            age =a;
            name =b;
        }
    }

    public static class U{
        int age ;
        String name;
    }


}
