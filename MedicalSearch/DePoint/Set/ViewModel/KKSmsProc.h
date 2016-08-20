//
//  KKSmsProc.h
//  DePoint
//
//  Created by kaki on 16/8/14.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKSmsProc : NSObject
+ (void)kk_smsSendByPhone:(NSString *)phone completionHandler:(void (^)(NSError *error, NSString *errMsg))completionHandler;
+ (void)kk_smsCheckByPhone:(NSString *)phone smsCode:(NSString *)code completionHandler:(void (^)(NSError *error, NSString *errMsg))completionHandler;
@end
