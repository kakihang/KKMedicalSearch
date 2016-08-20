//
//  KKAlertWithVerifyAndCancel.m
//  DePoint
//
//  Created by kaki on 16/8/16.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKAlertWithVerifyAndCancel.h"

@implementation KKAlertWithVerifyAndCancel

+ (void)kk_alertWithDelegate:(id)targetDelegate
                       title:(NSString *)title message:(NSString *)message
                 verifyTitle:(NSString *)verifyTitle verifyhandler:(void(^)(UIAlertController *alert))verifyhandler
                 cancelTitle:(NSString *)cancelTitle cancelhandler:(void(^)(UIAlertController *alert))cancelhandler
                 texthandler:(void(^)(UITextField *text))texthandler
                  completion:(void(^)())completion {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *verify = [UIAlertAction actionWithTitle:verifyTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        !verifyhandler?:verifyhandler(alert);
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        !cancelhandler?:cancelhandler(alert);
    }];
    if (texthandler) {
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            texthandler(textField);
        }];
    }
    [alert addAction:cancel];
    [alert addAction:verify];
    [targetDelegate presentViewController:alert animated:YES completion:^{
        !completion?:completion();
    }];
}

+ (void)kk_alertWithDelegate:(id)targetDelegate
                       title:(NSString *)title message:(NSString *)message
               verifyhandler:(void(^)(UIAlertController *alert))verifyhandler
               cancelhandler:(void(^)(UIAlertController *alert))cancelhandler
                  completion:(void(^)())completion {
    return [self kk_alertWithDelegate:targetDelegate title:title message:message verifyTitle:@"确定" verifyhandler:^(UIAlertController *alert) {
        !verifyhandler?:verifyhandler(alert);
    } cancelTitle:@"取消" cancelhandler:^(UIAlertController *alert) {
        !cancelhandler?:cancelhandler(alert);
    } texthandler:nil completion:^{
        !completion?:completion();
    }];
}

@end
