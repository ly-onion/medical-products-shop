package com.xxxx.portal.mapper;

import com.xxxx.common.pojo.Advertisement;
import com.xxxx.common.pojo.AdvertisementExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdvertisementMapper {
    long countByExample(AdvertisementExample example);

    int deleteByExample(AdvertisementExample example);

    int deleteByPrimaryKey(Integer adId);

    int insert(Advertisement record);

    int insertSelective(Advertisement record);

    List<Advertisement> selectByExampleWithBLOBs(AdvertisementExample example);

    List<Advertisement> selectByExample(AdvertisementExample example);

    Advertisement selectByPrimaryKey(Integer adId);

    int updateByExampleSelective(@Param("record") Advertisement record, @Param("example") AdvertisementExample example);

    int updateByExampleWithBLOBs(@Param("record") Advertisement record, @Param("example") AdvertisementExample example);

    int updateByExample(@Param("record") Advertisement record, @Param("example") AdvertisementExample example);

    int updateByPrimaryKeySelective(Advertisement record);

    int updateByPrimaryKeyWithBLOBs(Advertisement record);

    int updateByPrimaryKey(Advertisement record);
}