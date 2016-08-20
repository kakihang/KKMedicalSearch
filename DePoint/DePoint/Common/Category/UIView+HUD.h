//
//  UIView+HUD.h
//  TRProject
//
//  Created by tarena on 16/7/13.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)

- (void)showHUD;
- (void)hideHUD;

- (void)showWarning:(NSString *)msg;


- (void)kk_showAlertWithMessage:(NSString*)message;
- (void)kk_showAlertNoTitleWithMessage:(NSString*)message;
+ (void) kk_showAlertWithMessage:(NSString*)message ;
+ (void)kk_showAlertNoTitleWithMessage:(NSString *)message;
@end











