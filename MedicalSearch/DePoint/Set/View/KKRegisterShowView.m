//
//  KKRegisterShowView.m
//  DePoint
//
//  Created by kaki on 16/8/11.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKRegisterShowView.h"

@interface KKRegisterShowView()  
@property (nonatomic, weak) UIView *view; //
@property (nonatomic, assign) NSInteger index; //
@end


@implementation KKRegisterShowView

+ (instancetype)registerShowOnView:(UIView *)view index:(NSInteger)index{
    KKRegisterShowView *registerView = [[KKRegisterShowView alloc] init];
    [view bk_whenTapped:^{
        [view endEditing:YES];
    }];
    registerView.view = view;
    registerView.index = index;
    [registerView setupView];
    return registerView;
}


- (void)setupView {
    CGFloat height = KKScreenHeightPrecent(0.05);
    CGFloat topMargin = KKScreenHeightPrecent(0.001) + 64;
    CGFloat width = KKSCREENBOUNDSIZE.width/3.0;
    CGFloat labelWidth = width * 0.9;
    
    CGFloat sideMargin = KKScreenHeightPrecent(0.05);
    CGFloat heightMargin = KKScreenHeightPrecent(0.03);
    CGFloat sendAgainWidth = KKScreenWidthPrecent(0.28);
    CGFloat minMargin = KKScreenHeightPrecent(0.01);
    
    for (NSInteger i=0; i<3; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topMargin);
            make.left.mas_equalTo(i * width);
            make.size.mas_equalTo(CGSizeMake(labelWidth, height));
        }];
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"right_parenthesis_16"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [self.view addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label.mas_right);
            make.centerY.mas_equalTo(label);
        }];
        
        if (i == 0) {
            label.text = @"  1.输入手机号";
        } else if (i == 1) {
            label.text = @"  2.输入验证码";
        } else {
            label.text = @"  3.设置密码";
        }
        if (i == _index) {
            label.textColor = [UIColor redColor];
        }
    }
    
    if (self.index == 1) {
        UILabel *prompt = [UILabel kk_labelWithText:@"验证码短信已经发送到"];
        prompt.font = [UIFont systemFontOfSize:12];
        prompt.textColor = [UIColor grayColor];
        [self.view addSubview:prompt];
        [prompt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(topMargin + height);
            make.height.mas_equalTo(height);
        }];
        self.showPhoneLa = prompt;
        topMargin = topMargin + 10;
    }
    
    UITextField *textField = [UITextField kk_createWithPlaceholder:@"请输入您的手机号码"];
    textField.font = [UIFont systemFontOfSize:15];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topMargin + height + heightMargin);
        make.left.mas_equalTo(sideMargin);
        make.right.mas_equalTo(-sideMargin);
        make.height.mas_equalTo(height);
    }];
    self.phoneTf = textField;
    
    if (self.index == 2) {
        UITextField *verifyTf = [UITextField kk_createWithPlaceholder:@"请再次输入密码"];
        verifyTf.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:verifyTf];
        [verifyTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(textField.mas_bottom).mas_equalTo(minMargin);
            make.left.mas_equalTo(textField);
            make.size.mas_equalTo(textField);
        }];
        self.passVerifyTf = verifyTf;
        heightMargin = heightMargin + minMargin + height;
    }
    
    KKLoginRegisButton *button = [KKLoginRegisButton kk_buttonWithType:UIButtonTypeRoundedRect title:@"获取验证码"];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sideMargin * 2);
        make.right.mas_equalTo(-sideMargin * 2);
        make.height.mas_equalTo(height);
        make.top.mas_equalTo(textField.mas_bottom).mas_equalTo(heightMargin);
    }];
    button.enabled = NO;
    self.registerButton = button;
    
    if (self.index == 1) {
        UIButton *sendAgain = [UIButton kk_buttonWithType:UIButtonTypeCustom title:@"60s后重新发送"];;
        sendAgain.titleLabel.font = [UIFont systemFontOfSize:14];
        sendAgain.titleLabel.textAlignment = NSTextAlignmentRight;
        [sendAgain setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sendAgain = sendAgain;
        [self.view addSubview:_sendAgain];
        [_sendAgain mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(textField);
            make.right.mas_equalTo(-sideMargin);
            make.height.mas_equalTo(textField);
            make.width.mas_equalTo(sendAgainWidth);
        }];
        
        [textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-sideMargin - sendAgainWidth);
        }];
    }
}


@end
