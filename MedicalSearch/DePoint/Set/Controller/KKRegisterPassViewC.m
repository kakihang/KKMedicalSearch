//
//  KKRegisterPassViewC.m
//  DePoint
//
//  Created by kaki on 16/8/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKRegisterPassViewC.h"
#import "KKRegisterShowView.h"
#import "KKLoginProc.h"


@interface KKRegisterPassViewC ()
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) KKRegisterShowView *registerView; //
@end

@implementation KKRegisterPassViewC {
    NSString *_title;
}

- (instancetype)initWithPhone:(NSString *)phone title:(NSString *)title {
    if (self = [super init]) {
        _title = title;
        self.phoneNumber = phone;
    }
    return self;
}
- (instancetype)init {
    NSCAssert1(NO, @"请使用initWithPhone:进行初始化", __func__);
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:_title tintColor:KKGLOTINTCOLOR backgroundColor:[UIColor clearColor]];
    [self setNavBottmLinehidden:YES];
    [self.view kk_viewWithVisualEffName:@"130313604324531250"];
    
    [self registerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}


#pragma mark - 懒加载

- (KKRegisterShowView *)registerView {
    if(_registerView == nil) {
        _registerView = [KKRegisterShowView registerShowOnView:self.view index:2];
        [_registerView.registerButton setTitle:@"确认提交" forState:UIControlStateNormal];
        
        _registerView.phoneTf.placeholder = @"请输入密码";
        _registerView.phoneTf.secureTextEntry = YES;
        _registerView.phoneTf.keyboardType = UIKeyboardTypeDefault;
        [_registerView.phoneTf addTarget:self action:@selector(textFieldPassValueChange) forControlEvents:UIControlEventAllEditingEvents];
        
        _registerView.passVerifyTf.secureTextEntry = YES;
        _registerView.passVerifyTf.keyboardType = UIKeyboardTypeDefault;
        [_registerView.passVerifyTf addTarget:self action:@selector(textFieldPassValueChange) forControlEvents:UIControlEventAllEditingEvents];
        
        [_registerView.registerButton addTarget:self action:@selector(clickRegisterButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerView;
}


#pragma mark - 逻辑方法

- (void)textFieldPassValueChange {
    _registerView.registerButton.enabled = ([_registerView.phoneTf hasText] && [_registerView.passVerifyTf hasText]);
}

- (void)clickRegisterButton {
    [self.view showHUD];
    
    if ([_registerView.phoneTf.text isEqualToString:_registerView.passVerifyTf.text]) {
        __weak typeof(self) weakSelf = self;
        
        [KKLoginProc kk_registerWithPhone:_phoneNumber password:_registerView.passVerifyTf.text complehandler:^(BOOL isSuccessful, NSError *error) {
            [weakSelf.view hideHUD];
            if (isSuccessful) {
                [weakSelf.view showWarning:@"注册成功~"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                NSLog(@"error: %@", error);
                NSLog(@"error: %@ : %@", _phoneNumber, _registerView.passVerifyTf.text);
                [self.view kk_showAlertNoTitleWithMessage:@"密码设置失败"];
            }
        }];
    } else {
        [self.view hideHUD];
        [self.view kk_showAlertNoTitleWithMessage:@"密码不一致，请确认"];
    }
}


#pragma mark - 登录处理


@end
