package com.xxxx.manager.controller;

import com.xxxx.common.pojo.Advertisement;
import com.xxxx.common.pojo.Goods;
import com.xxxx.common.result.BaseResult;
import com.xxxx.common.result.FileResult;
import com.xxxx.common.util.TimeExchange;
import com.xxxx.manager.pojo.AdvertisementImages;
import com.xxxx.manager.pojo.Brand;
import com.xxxx.manager.pojo.GoodsCategory;
import com.xxxx.manager.pojo.GoodsImages;
import com.xxxx.manager.service.AdManagerService;
import com.xxxx.manager.service.ImagesService;
import com.xxxx.manager.service.UploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.ParseException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/5 18:33
 */
@Controller
@RequestMapping("adManage")
public class AdvertiseController {

    @Autowired
    private AdManagerService adManagerService;

    @RequestMapping("list")
    public String adListForPage() {
        return "ads/ads-list";
    }

    @Autowired
    private UploadService uploadService;

    @Autowired
    private ImagesService adImageService;

    /**
     * 商品列表-分页查询
     *
     * @param adName
     * @param pageNum
     * @return
     */
    @RequestMapping("listForPage")
    @ResponseBody
    public BaseResult selectGoodsListByPage(String adName, Integer pageNum) {
        return adManagerService.selectAdListForPage(adName, pageNum);
    }

    /**
     * 商品-新增-页面跳转
     *
     * @return
     */
    @RequestMapping("add/{id}")
    public String adAdd(@PathVariable("id") Integer adId, Model model) {
        if (adId != -1) {
            Advertisement advertisement = adManagerService.selectAdByAdId(adId);
            model.addAttribute("ad", advertisement);
        }
        return "ads/ads-add";
    }


    @RequestMapping("save")
    @ResponseBody
    public BaseResult saveAd(Advertisement advertisement) {
        if (advertisement.getIsShow().equalsIgnoreCase("否")){
            if (advertisement.getAdId() == null) {
                return adManagerService.saveAd(advertisement);
            } else {
                return adManagerService.updateAd(advertisement);
            }
        }else {
            if (adManagerService.checkAmount() >=5) {
                return BaseResult.error();
            }else {
                if (advertisement.getAdId() == null) {
                    return adManagerService.saveAd(advertisement);
                } else {
                    return adManagerService.updateAd(advertisement);
                }
            }
        }

    }

    @RequestMapping(value = "list/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public BaseResult deleteAd(@PathVariable("id") Integer adId) {
        return adManagerService.deleteAd(adId);
    }


    /**
     * 商品相册-保存
     *
     * @param file
     * @param adId
     * @return
     * @throws IOException
     */
    @RequestMapping("images/save")
    @ResponseBody
    public BaseResult saveGoodsImages(MultipartFile file, Integer adId) throws IOException {
        //获取文件名并重命名，防止文件名一样导致覆盖
        String filename = file.getOriginalFilename();
        //加上日期在上传时会根据日期创建目录
        String date = DateTimeFormatter.ofPattern("yyyy/MM/dd/").format(LocalDateTime.now());
        filename = date + System.currentTimeMillis() +
                filename.substring(filename.lastIndexOf("."));
        FileResult fileResult = uploadService.upload(file.getInputStream(), filename);
        //判断图片是否上传成功
        if (!StringUtils.isEmpty(fileResult.getFileUrl())) {
            AdvertisementImages advertisementImages = new AdvertisementImages();
            advertisementImages.setAdId(adId);
            advertisementImages.setAdImageUrl(fileResult.getFileUrl());
            return adImageService.saveAdImages(advertisementImages);
        } else {
            return BaseResult.error();
        }
    }

    @RequestMapping("modifyShow")
    @ResponseBody
    public BaseResult modifyShow(Integer adId, String isShow) {
        Advertisement advertisement = adManagerService.selectAdByAdId(adId);
        advertisement.setEnabled(isShow.equals("是") ? (byte) 1 : (byte) 0);
        return adManagerService.updateAd(advertisement);
    }
}
