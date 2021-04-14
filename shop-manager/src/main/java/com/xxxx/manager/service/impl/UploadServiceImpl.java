package com.xxxx.manager.service.impl;

import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.Region;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import com.xxxx.common.result.FileResult;
import com.xxxx.manager.service.UploadService;
import org.springframework.stereotype.Service;

import java.io.InputStream;

/**
 * @PROJECT_NAME: uoload
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/13 21:12
 */
@Service
public class UploadServiceImpl implements UploadService {

    @Override
    public FileResult upload(InputStream inputStream, String filename) {
        FileResult fileResult = new FileResult();
        //构造一个带指定 Region 对象的配置类
        Configuration cfg = new Configuration(Region.region2());
        //...其他参数参考类注释
        UploadManager uploadManager = new UploadManager(cfg);
        //...生成上传凭证，然后准备上传
        String accessKey = "wKvLlppM5JRO9mwP_coeppdMi8JW9ycpNJyNKcmk";
        String secretKey = "5quzEt6mMwbAEg59bW43B4SUONDmUscz2Rmw5pyb";
        String bucket = "medical-shop";
        //默认不指定key的情况下，以文件内容的hash值作为文件名
        String key = filename;
        Auth auth = Auth.create(accessKey, secretKey);
        String upToken = auth.uploadToken(bucket);
//        String result = "";
        try {
            Response response = uploadManager.put(inputStream,key,upToken,null, null);
            //解析上传成功的结果
//                DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
//                System.out.println(putRet.key);
//                System.out.println(putRet.hash);
            if (response.statusCode == 200){
                fileResult.setSuccess("success");
                fileResult.setMessage("上传成功");
                fileResult.setFileUrl("http://qri5nwbvp.hn-bkt.clouddn.com/" + filename);
                return fileResult;
            }else {
                fileResult.setError("error");
                fileResult.setMessage("上传失败");
                return fileResult;
            }
        } catch (QiniuException ex) {
            Response r = ex.response;
            System.err.println(r.toString());
            fileResult.setError("error");
            fileResult.setMessage("上传失败");
            try {
                System.err.println(r.bodyString());
            } catch (QiniuException ex2) {
                //ignore
            }
        }
        return fileResult;
    }
}
