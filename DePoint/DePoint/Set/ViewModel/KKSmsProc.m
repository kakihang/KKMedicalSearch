//
//  KKSmsProc.m
//  DePoint
//
//  Created by kaki on 16/8/14.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKSmsProc.h"
#import <SMS_SDK/SMSSDK.h>

@implementation KKSmsProc


NSString *zone = @"86";

+ (void)kk_smsSendByPhone:(NSString *)phone
        completionHandler:(void (^)(NSError *error, NSString *errMsg))completionHandler {
    return [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phone zone:zone customIdentifier:nil result:^(NSError *error) {
        NSString *errMsg = error.userInfo[@"getVerificationCode"];
        errMsg = errMsg?errMsg:@"验证码发送失败";
        errMsg = errMsg.length>=4?errMsg:@"验证码发送失败";
        !completionHandler?:completionHandler(error, errMsg);
    }];
}

+ (void)kk_smsCheckByPhone:(NSString *)phone
                   smsCode:(NSString *)code
         completionHandler:(void (^)(NSError *error, NSString *errMsg))completionHandler {
    return [SMSSDK commitVerificationCode:code phoneNumber:phone zone:zone result:^(NSError *error) {
        NSString *errMsg = error.userInfo[@"commitVerificationCode"];
        errMsg = errMsg?errMsg:@"验证码错误,请重新输入";
        errMsg = errMsg.length>=4?errMsg:@"验证码错误,请重新输入";
        !completionHandler?:completionHandler(error, errMsg);
    }];
}

@end
