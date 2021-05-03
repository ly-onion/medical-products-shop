package com.xxxx.portal.service.impl;

import com.tencentcloudapi.captcha.v20190722.CaptchaClient;
import com.tencentcloudapi.captcha.v20190722.models.DescribeCaptchaResultRequest;
import com.tencentcloudapi.captcha.v20190722.models.DescribeCaptchaResultResponse;
import com.tencentcloudapi.common.Credential;
import com.tencentcloudapi.common.exception.TencentCloudSDKException;
import com.tencentcloudapi.common.profile.ClientProfile;
import com.tencentcloudapi.common.profile.HttpProfile;
import com.xxxx.common.result.BaseResult;
import com.xxxx.portal.service.CaptchaService;
import org.springframework.stereotype.Service;

/**
 * 验证服务实现类
 *
 * @author zhoubin
 * @since 1.0.0
 */
@Service
public class CaptchaServiceImpl implements CaptchaService {

    /**
     * 校验验证码
     *
     * @param ticket
     * @param randStr
     * @return
     */
    @Override
    public BaseResult captcha(String ticket, String randStr) {
        try {

            Credential cred = new Credential("AKIDeCUabQyLhnnVzEn1WkjSu5ze4C3eO5tR", "UifLlvoQ1PYZQ1MQFm5PRItEI6ex0mHW");

            HttpProfile httpProfile = new HttpProfile();
            httpProfile.setEndpoint("captcha.tencentcloudapi.com");

            ClientProfile clientProfile = new ClientProfile();
            clientProfile.setHttpProfile(httpProfile);

            CaptchaClient client = new CaptchaClient(cred, "", clientProfile);

            DescribeCaptchaResultRequest req = new DescribeCaptchaResultRequest();
            req.setCaptchaType(9L);
            req.setTicket(ticket);
            req.setUserIp("127.0.0.1");
            req.setRandstr(randStr);
            req.setCaptchaAppId(2096951909L);
            req.setAppSecretKey("0zf5CiXWosh9b_MPWXilqsw**");

            DescribeCaptchaResultResponse resp = client.DescribeCaptchaResult(req);

            System.out.println(DescribeCaptchaResultResponse.toJsonString(resp));
        } catch (TencentCloudSDKException e) {
            System.out.println(e.toString());
        }
        return BaseResult.success();
    }

}