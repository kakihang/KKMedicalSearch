//
//  KKAlertWithVerifyAndCancel.h
//  DePoint
//
//  Created by kaki on 16/8/16.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKAlertWithVerifyAndCancel : NSObject
+ (void)kk_alertWithDelegate:(id)targetDelegate
                       title:(NSString *)title message:(NSString *)message
                 verifyTitle:(NSString *)verifyTitle verifyhandler:(void(^)(UIAlertController *alert))verifyhandler
                 cancelTitle:(NSString *)cancelTitle cancelhandler:(void(^)(UIAlertController *alert))cancelhandler
                 texthandler:(void(^)(UITextField *text))texthandler
                  completion:(void(^)())completion;

+ (void)kk_alertWithDelegate:(id)targetDelegate
                       title:(NSString *)title message:(NSString *)message
               verifyhandler:(void(^)(UIAlertController *alert))verifyhandler
               cancelhandler:(void(^)(UIAlertController *alert))cancelhandler
                  completion:(void(^)())completion;

@end
