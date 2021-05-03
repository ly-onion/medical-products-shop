package com.xxxx.rpc.service.impl;

import com.alibaba.dubbo.config.annotation.Service;
import com.tencentcloudapi.common.Credential;
import com.tencentcloudapi.common.exception.TencentCloudSDKException;
import com.tencentcloudapi.common.profile.ClientProfile;
import com.tencentcloudapi.common.profile.HttpProfile;
import com.tencentcloudapi.sms.v20190711.SmsClient;
import com.tencentcloudapi.sms.v20190711.models.SendSmsRequest;
import com.tencentcloudapi.sms.v20190711.models.SendSmsResponse;
import com.xxxx.common.pojo.Admin;
import com.xxxx.common.result.BaseResult;
import com.xxxx.rpc.service.SendMessageService;
import org.springframework.stereotype.Component;

/**
 * 短信发送服务实现类
 *
 * @author zhoubin
 * @since 1.0.0
 */
@Service(interfaceClass = SendMessageService.class)
@Component
public class SendMessageServiceImpl implements SendMessageService {

    /**
     * 发送短信
     *
     * @param admin
     * @return
     */
    @Override
    public BaseResult sendMessage(Admin admin) {
//		try{
//			//实例化一个认证对象，获取签名串
//			Credential cred = new Credential("AKID2Xnoa8iWKssfNrF5pKZv2ye5HEvMHBHT", "BnEPLdgT0IMCnAdsrb5NisnP2UmuqZ3N");
//			//实例化HttpProfile对象，调用短信发送接口的url
//			HttpProfile httpProfile = new HttpProfile();
//			httpProfile.setEndpoint("sms.tencentcloudapi.com");
//			//实例化ClientProfile对象
//			ClientProfile clientProfile = new ClientProfile();
//			clientProfile.setHttpProfile(httpProfile);
//			//实例化sms客户端
//			SmsClient client = new SmsClient(cred, "ap-shanghai", clientProfile);
//			//入参
//			/**
//			 * 第一个参数：电话号码
//			 * 第二个参数：模板id
//			 * 第三个参数：签名内容
//			 * 第四个参数：短信sdkappid
//			 */
//			String params = "{\"PhoneNumberSet\":[\"86"+phoneNum+"\"],\"TemplateID\":\"490150\",\"Sign\":\"程序猿学习栈\"," +
//					"\"SmsSdkAppid\":\"1400291704\"}";
//			//格式化json
//			SendSmsRequest req = SendSmsRequest.fromJsonString(params, SendSmsRequest.class);
//			//发送请求
//			SendSmsResponse resp = client.SendSms(req);
//			if ("ok".equalsIgnoreCase(resp.getSendStatusSet()[0].getCode())){
//				return BaseResult.success();
//			}
//			System.out.println(SendSmsRequest.toJsonString(resp));
//		} catch (TencentCloudSDKException e) {
//			System.out.println(e.toString());
//		}
//		return BaseResult.error();
        try {

            Credential cred = new Credential("AKIDeCUabQyLhnnVzEn1WkjSu5ze4C3eO5tR", "UifLlvoQ1PYZQ1MQFm5PRItEI6ex0mHW");

            HttpProfile httpProfile = new HttpProfile();
            httpProfile.setEndpoint("sms.tencentcloudapi.com");

            ClientProfile clientProfile = new ClientProfile();
            clientProfile.setHttpProfile(httpProfile);

            SmsClient client = new SmsClient(cred, "", clientProfile);

            SendSmsRequest req = new SendSmsRequest();
            String[] phoneNumberSet1 = {"+86" + admin.getEmail()};
            req.setPhoneNumberSet(phoneNumberSet1);

            req.setTemplateID("946475");
            req.setSign("洋葱java开发记录");

            String[] templateParamSet1 = {admin.getUserName(), admin.getPassword()};
            req.setTemplateParamSet(templateParamSet1);

            req.setSmsSdkAppid("1400516817");

            SendSmsResponse resp = client.SendSms(req);
            if ("ok".equalsIgnoreCase(resp.getSendStatusSet()[0].getCode())) {
                return BaseResult.success();
            }

            System.out.println(SendSmsResponse.toJsonString(resp));
        } catch (TencentCloudSDKException e) {
            System.out.println(e.toString());
        }
        return BaseResult.error();
    }
}