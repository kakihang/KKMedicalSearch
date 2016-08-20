//
//  KKLoginShowView.h
//  DePoint
//
//  Created by kaki on 16/8/10.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKLoginRegisButton.h"
#import "KKSquareButton.h"


@interface KKLoginShowView : UIView

@property (nonatomic, strong) UIButton *quickLoginBtn; // 快速登录按钮
@property (nonatomic, strong) UIButton *accLoginBtn; // 账号登录按钮

@property (nonatomic, strong) UIButton *sendMag; // 发送验证码
@property (nonatomic, strong) UITextField *userTf; // 用户输入框
@property (nonatomic, strong) UITextField *passTf; // 密码输入框
@property (nonatomic, strong) KKLoginRegisButton *loginBtn; // 登录按钮
@property (nonatomic, strong) UIButton *forgetBtn; // 忘记密码

@property (nonatomic, strong) KKSquareButton *qqLoginBtn; // qq登录
//@property (nonatomic, strong) KKSquareButton *wxLoginBtn; // 微信登录
+ (instancetype)loginShowOnView:(UIView *)view;





@end
