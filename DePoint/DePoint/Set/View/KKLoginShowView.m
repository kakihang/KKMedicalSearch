//
//  KKLoginShowView.m
//  DePoint
//
//  Created by kaki on 16/8/10.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKLoginShowView.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface KKLoginShowView()
@property (nonatomic, weak) UIView *mainView;
@property (nonatomic, strong) UIView *loginBgView; // 登录背景的view
@property (nonatomic, strong) UIView *oneKeyLoginBgView; // 一键登录背景view

@property (nonatomic, strong) KKJustifiedLabel *userLa; // 用户
@property (nonatomic, strong) KKJustifiedLabel *passLa; // 密码
@property (nonatomic, strong) UIButton *registerBtn; // 注册按钮
@property (nonatomic, strong) UIView *tagView; //标签

@end


@implementation KKLoginShowView

+ (instancetype)loginShowOnView:(UIView *)view {
    KKLoginShowView *loginView = [[KKLoginShowView alloc] init];
    loginView.mainView = view;
    [loginView oneKeyLoginBgView];
    [loginView loginBgView];
    [loginView setQuickAndAccountLoginButton];
    [loginView setLoginThird];
    return loginView;
}

#pragma mark - 登录

- (UIView *)loginBgView {
    if(_loginBgView == nil) {
        _loginBgView = [[UIView alloc] init];
        [self.mainView addSubview:_loginBgView];
        [_loginBgView setBackgroundColor:[UIColor clearColor]];
        [_loginBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(64);
            make.bottom.mas_equalTo(self.oneKeyLoginBgView.mas_top);
        }];
        
        _loginBgView.userInteractionEnabled = YES;
        [_loginBgView bk_whenTapped:^{
            [_loginBgView endEditing:YES];
        }];
        
        CGFloat margin = KKScreenWidthPrecent(0.08);
        CGFloat height = KKScreenHeightPrecent(0.05);
        CGFloat topMargin = KKScreenHeightPrecent(0.1);
        CGFloat phoneLaWidth = KKScreenWidthPrecent(0.22);
        CGFloat sendMsgWidth = KKScreenWidthPrecent(0.2);
        
        // 快速登录
        _quickLoginBtn = [UIButton kk_buttonWithType:UIButtonTypeRoundedRect title:@"快速登录"];
        _quickLoginBtn.backgroundColor = [UIColor clearColor];
        [_loginBgView addSubview:_quickLoginBtn];
        [_quickLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin);
            make.width.mas_equalTo(KKScreenWidthPrecent(0.5)-margin);
            make.height.mas_equalTo(height);
            make.top.mas_equalTo(topMargin);
        }];
        
        _accLoginBtn = [UIButton kk_buttonWithType:UIButtonTypeRoundedRect title:@"账号登录"];
        _accLoginBtn.backgroundColor = [UIColor clearColor];
        [_loginBgView addSubview:_accLoginBtn];
        [_accLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_quickLoginBtn.mas_right);
            make.size.mas_equalTo(_quickLoginBtn);
            make.top.mas_equalTo(_quickLoginBtn.mas_top);
        }];
        
        _tagView = [[UIView alloc] init];
        _tagView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.7];
        [_loginBgView addSubview:_tagView];
        [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_quickLoginBtn);
            make.top.mas_equalTo(_quickLoginBtn.mas_bottom);
            make.height.mas_equalTo(_quickLoginBtn).multipliedBy(0.1);
            make.width.mas_equalTo(_quickLoginBtn).multipliedBy(0.6);
        }];
        
        _userLa = [KKJustifiedLabel kk_labelWithText:@"手机号码："];
        _userLa.backgroundColor = [UIColor clearColor];
        [_loginBgView addSubview:_userLa];
        [_userLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_quickLoginBtn.mas_left);
            make.top.mas_equalTo(_tagView.mas_bottom);
            make.height.mas_equalTo(_quickLoginBtn);
            make.width.mas_equalTo(phoneLaWidth);
        }];
        
        _userTf = [UITextField kk_createWithPlaceholder:@"请输入手机号码"];
        _userTf.backgroundColor = [UIColor clearColor];
        _userTf.keyboardType = UIKeyboardTypeNumberPad;
        [_loginBgView addSubview:_userTf];
        [_userTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_userLa.mas_right);
            make.height.mas_equalTo(_userLa);
            make.top.mas_equalTo(_userLa);
        }];
        
        _sendMag = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendMag.titleLabel.font = [UIFont systemFontOfSize:14];
        [_sendMag setTitleColor:KKButtonNormalColor forState:UIControlStateNormal];
        [_sendMag setTitleColor:KKButtonDisableColor forState:UIControlStateDisabled];
        [_sendMag setTitle:@"发送验证码" forState:UIControlStateNormal];
        _sendMag.enabled = NO;
        _sendMag.backgroundColor = [UIColor clearColor];
        [_loginBgView addSubview:_sendMag];
        [_sendMag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_userTf.mas_right);
            make.right.mas_equalTo(_accLoginBtn);
            make.height.mas_equalTo(_userLa);
            make.top.mas_equalTo(_userTf);
            make.width.mas_equalTo(sendMsgWidth);
        }];
        
        _passLa = [KKJustifiedLabel kk_labelWithText:@"验证码："];
        _passLa.backgroundColor = [UIColor clearColor];
        [_loginBgView addSubview:_passLa];
        [_passLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_quickLoginBtn.mas_left);
            make.top.mas_equalTo(_userLa.mas_bottom);
            make.size.mas_equalTo(_userLa);
        }];
        
        _passTf = [UITextField kk_createWithPlaceholder:@"请输入验证码"];
        _passTf.backgroundColor = [UIColor clearColor];
        [_loginBgView addSubview:_passTf];
        [_passTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_passLa.mas_right);
            make.height.mas_equalTo(_passLa);
            make.top.mas_equalTo(_passLa);
            make.right.mas_equalTo(_accLoginBtn);
        }];
        
        _forgetBtn = [UIButton kk_buttonWithTitle:@"忘记密码?"];
        _forgetBtn.backgroundColor = [UIColor clearColor];
        [_loginBgView addSubview:_forgetBtn];
        [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_passLa.mas_bottom);
            make.right.mas_equalTo(_accLoginBtn);
        }];
        
        _loginBtn = [KKLoginRegisButton kk_buttonWithType:UIButtonTypeRoundedRect title:@"登录"];
        _loginBtn.enabled = NO;
        [_loginBgView addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_passLa);
            make.height.mas_equalTo(_passLa);
            make.right.mas_equalTo(_accLoginBtn);
            make.top.mas_equalTo(_forgetBtn.mas_bottom).mas_equalTo(margin*0.8);
        }];
    }
    return _loginBgView;
}

#pragma mark - 第三方登录
- (UIView *)oneKeyLoginBgView {
    if(_oneKeyLoginBgView == nil) {
        _oneKeyLoginBgView = [[UIView alloc] init];
        [self.mainView addSubview:_oneKeyLoginBgView];
        [_oneKeyLoginBgView setBackgroundColor:[UIColor clearColor]];
        [_oneKeyLoginBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(KKScreenHeightPrecent(0.4));
        }];
        
        _oneKeyLoginBgView.userInteractionEnabled = YES;
        [_oneKeyLoginBgView bk_whenTapped:^{
            [_loginBgView endEditing:YES];
        }];
        
        // 微信一键登录
        //        _wxLoginBtn = [KKSquareButton buttonWithTitle:@"微信登录" imgName:@"wx24"];
        //        [_oneKeyLoginBgView addSubview:_wxLoginBtn];
        //        [_wxLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.mas_equalTo(_oneKeyLoginBgView.mas_centerX).mas_equalTo(KKScreenWidthPrecent(0.1));
        //            make.size.mas_equalTo(_qqLoginBtn);
        //            make.bottom.mas_equalTo(_qqLoginBtn);
        //        }];
        
        UILabel *label = [UILabel kk_labelWithText:@"第三方登录"];
        label.textColor = KKCOLOR(53, 53, 53, 0.8);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [_oneKeyLoginBgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_greaterThanOrEqualTo(KKScreenHeightPrecent(0.05));
            make.width.mas_equalTo(KKScreenWidthPrecent(0.3));
        }];
        
        UILabel *left = [[UILabel alloc] init];
        left.backgroundColor = KKCOLOR(100, 100, 100, 1);
        [_oneKeyLoginBgView addSubview:left];
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(label);
            make.left.mas_equalTo(KKScreenWidthPrecent(0.1));
            make.right.mas_equalTo(label.mas_left).mas_equalTo(KKScreenWidthPrecent(-0.01));
            make.height.mas_equalTo(0.5);
        }];
        
        UILabel *right = [[UILabel alloc] init];
        right.backgroundColor = KKCOLOR(100, 100, 100, 1);
        [_oneKeyLoginBgView addSubview:right];
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(label);
            make.left.mas_equalTo(label.mas_right).mas_equalTo(KKScreenWidthPrecent(0.01));
            make.right.mas_equalTo(KKScreenWidthPrecent(-0.1));
            make.height.mas_equalTo(0.5);
        }];
    }
    return _oneKeyLoginBgView;
}

#pragma mark - 第三方 QQ
- (void)setLoginThird {
    CGFloat top = KKScreenHeightPrecent(0.15);
    CGFloat width = KKScreenHeightPrecent(0.4) * 0.16;
    CGFloat height = width + 25;
    CGFloat margin = KKScreenWidthPrecent(0.1);
    NSInteger number = 0;
    CGFloat x = 0;
    
    if ([TencentOAuth iphoneQQInstalled] && [TencentOAuth iphoneQQSupportSSOLogin]) {
        number++;
    }
    
    x = (KKSCREENBOUNDSIZE.width - number * width - margin * (number - 1))/2;
    
    
    if ([TencentOAuth iphoneQQInstalled] && [TencentOAuth iphoneQQSupportSSOLogin]) {
        _qqLoginBtn = [KKSquareButton buttonWithTitle:@"QQ" imgName:@"qq24"];
        _qqLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_oneKeyLoginBgView addSubview:_qqLoginBtn];
        [_qqLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(top);
            make.left.mas_equalTo(x);
            make.size.mas_equalTo(CGSizeMake(width, height));
        }];
        x = width + margin;
    }
}


#pragma mark - 快速登录/账号登录设置

- (void)setQuickAndAccountLoginButton {
    [self.quickLoginBtn addTarget:self action:@selector(clickQuickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    [self.accLoginBtn addTarget:self action:@selector(clickAccountLoginButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickQuickLoginButton {
    self.passTf.text = @"";
    self.passTf.secureTextEntry = NO;
    self.passTf.placeholder = @"请输入验证码";
    self.passTf.keyboardType = UIKeyboardTypeNumberPad;
    self.passLa.text = @"验证码：";
    self.sendMag.hidden = NO;
    self.userLa.text = @"手机号码：";
    self.userTf.placeholder = @"请输入手机号码";
    self.userTf.keyboardType = UIKeyboardTypeNumberPad;
    [self changeTagCenterX:_quickLoginBtn.centerX];
}

- (void)clickAccountLoginButton {;
    self.passTf.text = @"";
    self.passTf.secureTextEntry = YES;
    self.passTf.placeholder = @"请输入密码";
    self.passTf.keyboardType = UIKeyboardTypeDefault;
    self.passLa.text = @"密码：";
    self.sendMag.hidden = YES;
    self.userLa.text = @"账号：";
    self.userTf.placeholder = @"输入账号或手机号";
    self.userTf.keyboardType = UIKeyboardTypeDefault;
    [self changeTagCenterX:_accLoginBtn.centerX];
}

#pragma mark - tag

- (void)changeTagCenterX:(CGFloat)centerX {
    if (_tagView.centerX != centerX) {
        [UIView animateWithDuration:0.5 animations:^{
            _tagView.centerX = centerX;
        }];
    }
}

@end
