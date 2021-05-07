package com.xxxx.manager.mapper;

import com.xxxx.manager.pojo.AdvertisementImages;
import com.xxxx.manager.pojo.AdvertisementImagesExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdvertisementImagesMapper {
    long countByExample(AdvertisementImagesExample example);

    int deleteByExample(AdvertisementImagesExample example);

    int deleteByPrimaryKey(Integer imgId);

    int insert(AdvertisementImages record);

    int insertSelective(AdvertisementImages record);

    List<AdvertisementImages> selectByExample(AdvertisementImagesExample example);

    AdvertisementImages selectByPrimaryKey(Integer imgId);

    int updateByExampleSelective(@Param("record") AdvertisementImages record, @Param("example") AdvertisementImagesExample example);

    int updateByExample(@Param("record") AdvertisementImages record, @Param("example") AdvertisementImagesExample example);

    int updateByPrimaryKeySelective(AdvertisementImages record);

    int updateByPrimaryKey(AdvertisementImages record);
}