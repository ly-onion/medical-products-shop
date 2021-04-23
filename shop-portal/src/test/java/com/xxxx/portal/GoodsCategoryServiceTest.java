package com.xxxx.portal;

import com.alibaba.dubbo.config.annotation.Reference;
import com.xxxx.common.util.JsonUtil;
import com.xxxx.rpc.service.GoodsCategoryService;
import com.xxxx.rpc.vo.GoodsCategoryVo;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/22 17:18
 */
@SpringBootTest
public class GoodsCategoryServiceTest {
    // dubbo 提供了 @Reference 注解，可替换 @Autowired 注解，用于引入远程服务
    @Reference(interfaceClass = GoodsCategoryService.class)
    private GoodsCategoryService goodsCategoryService;

    @Test
    public void testSelectCategoryListForView() {
        List<GoodsCategoryVo> list = goodsCategoryService.selectCategoryListForView();
        System.out.println(JsonUtil.object2JsonStr(list));
    }
}
