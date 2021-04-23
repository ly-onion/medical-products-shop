package com.xxxx.manager.controller;

import com.xxxx.common.result.BaseResult;
import com.xxxx.common.result.FileResult;
import com.xxxx.manager.pojo.Brand;
import com.xxxx.manager.pojo.Goods;
import com.xxxx.manager.pojo.GoodsCategory;
import com.xxxx.manager.pojo.GoodsImages;
import com.xxxx.manager.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:商品分类
 * @USER: 洋葱
 * @DATE: 2021/4/9 16:22
 */
@Controller
@RequestMapping("goods")
public class GoodsController {

    @Autowired
    private GoodsCategoryService goodsCategoryService;
    @Autowired
    private BrandService brandService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private GoodsImagesService goodsImagesService;
    @Autowired
    private UploadService uploadService;

    /*
     * 跳转商品列表页
     * */
    @RequestMapping("category/list")
    public String categoryList(Model model) {
        model.addAttribute("gcvList", goodsCategoryService.selectCategoryListForView());
        return "goods/category/category-list";
    }

    /*
     * 跳转商品新增页
     * */
    @RequestMapping("category/add")
    public String categoryAdd(Model model) {
        List<GoodsCategory> gcList = goodsCategoryService.selectCategoryTopList();
        model.addAttribute("gcList", gcList);
        return "goods/category/category-add";
    }

    /*
     * 商品分类-新增分类-级联查询
     * */
    @RequestMapping("category/{parentId}")
    @ResponseBody
    public List<GoodsCategory> selectCatagoryList(@PathVariable Short parentId) {
        return goodsCategoryService.selectCategoryByParentId(parentId);
    }

    /*
     * 商品分类-新增分类-保存分类
     * */
    @RequestMapping("category/save")
    @ResponseBody
    public BaseResult categorySave(GoodsCategory goodsCategory) {
        int result = goodsCategoryService.categorySave(goodsCategory);
        return result > 0 ? BaseResult.success() : BaseResult.error();
    }

    /**
     * 商品-列表页面跳转
     *
     * @return
     */
    @RequestMapping("list")
    public String goodsList(Model model) {
        //返回所有商品分类
        model.addAttribute("gcList", goodsCategoryService.selectCategoryList());
        //返回所有商品品牌
        model.addAttribute("brandList", brandService.selectBrandList());
        return "goods/goods-list";
    }

    /**
     * 商品-新增-页面跳转
     *
     * @return
     */
    @RequestMapping("add")
    public String goodsAdd(Model model) {
        //查询顶级分类
        List<GoodsCategory> gcList = goodsCategoryService.selectCategoryTopList();
        model.addAttribute("gcList", gcList);

        List<Brand> brandList = brandService.selectBrandList();
        model.addAttribute("brandList", brandList);
        return "goods/goods-add";
    }

    /**
     * 商品保存
     *
     * @param goods
     * @return
     */
    @RequestMapping("save")
    @ResponseBody
    public BaseResult saveGoods(Goods goods) {
        return goodsService.saveGoods(goods);
    }


    /**
     * 商品相册-保存
     *
     * @param file
     * @param goodsId
     * @return
     * @throws IOException
     */
    @RequestMapping("images/save")
    @ResponseBody
    public BaseResult saveGoodsImages(MultipartFile file, Integer goodsId) throws IOException {
        //获取文件名并重命名，防止文件名一样导致覆盖
        String filename = file.getOriginalFilename();
        //加上日期在上传时会根据日期创建目录
        String date = DateTimeFormatter.ofPattern("yyyy/MM/dd/").format(LocalDateTime.now());
        filename = date + System.currentTimeMillis() +
                filename.substring(filename.lastIndexOf("."));
        FileResult fileResult = uploadService.upload(file.getInputStream(), filename);
        //判断图片是否上传成功
        if (!StringUtils.isEmpty(fileResult.getFileUrl())) {
            GoodsImages goodsImages = new GoodsImages();
            goodsImages.setGoodsId(goodsId);
            goodsImages.setImageUrl(fileResult.getFileUrl());
            return goodsImagesService.saveGoodsImages(goodsImages);
        } else {
            return BaseResult.error();
        }
    }

    /**
     * 商品列表-分页查询
     * @param goods
     * @param pageNum
     * @param pageSize
     * @return
     */
    @RequestMapping("listForPage")
    @ResponseBody
    public BaseResult selectGoodsListByPage(Goods goods, Integer pageNum, Integer pageSize){
        return goodsService.selectGoodsListByPage(goods, pageNum, pageSize);
    }
}
