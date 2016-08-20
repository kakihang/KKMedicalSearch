//
//  UIView+HUD.m
//  TRProject
//
//  Created by tarena on 16/7/13.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "UIView+HUD.h"

@implementation UIView (HUD)
- (void)showHUD{
    [self hideHUD]; //先隐藏其他的提示
    //再添加新的. 这样可以保证只有一个提示
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    //最长转圈的时间30
    [hud hide:YES afterDelay:30];
}
- (void)hideHUD{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}
- (void)showWarning:(NSString *)msg{
    [self hideHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    [hud hide:YES afterDelay:1.5];
}


- (void) kk_showAlertWithMessage:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
- (void) kk_showAlertNoTitleWithMessage:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

+ (void)kk_showAlertNoTitleWithMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}
+ (void) kk_showAlertWithMessage:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


@end












