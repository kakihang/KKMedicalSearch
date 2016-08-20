//
//  KKRegisterViewC.m
//  DePoint
//
//  Created by kaki on 16/8/11.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKRegisterViewC.h"
#import "KKRegisterShowView.h"
#import "KKRegisterMsgViewC.h"
#import "KKSmsProc.h"
#import "KKLoginProc.h"

@interface KKRegisterViewC()
@property (nonatomic, strong) KKRegisterShowView *registerView; //
@end


@implementation KKRegisterViewC {
    NSString *_title;
    BOOL _isRegister;
}

- (instancetype)initWitTitle:(NSString *)title isRegister:(BOOL)isRegister {
    if (self = [super init]) {
        _title = title;
        _isRegister = isRegister;
    }
    return self;
}
- (instancetype)init {
    NSCAssert1(NO, @"%p: 请使用initWitTitle:进行初始化", __func__);
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:_title tintColor:KKGLOTINTCOLOR backgroundColor:[UIColor clearColor]];
    [self setNavBottmLinehidden:YES];
    [self.view kk_viewWithVisualEffName:@"130313604324531250"];
    self.registerView = [KKRegisterShowView registerShowOnView:self.view index:0];
    
    [self.registerView.registerButton addTarget:self action:@selector(clickRegisterButtonf) forControlEvents:UIControlEventTouchUpInside];
    [self.registerView.phoneTf addTarget:self action:@selector(changeRegisterButton) forControlEvents:UIControlEventAllEditingEvents];
}

- (void)clickRegisterButtonf {
    [self.view showHUD];
    __weak typeof(self) weakSelf = self;
    [KKLoginProc kk_checkPhoneExist:self.registerView.phoneTf.text complehandler:^(NSError *error, BOOL isExist) {
        if (!error) {
            if (isExist && _isRegister) {
                [weakSelf.view hideHUD];
                [weakSelf.view kk_showAlertNoTitleWithMessage:@"手机号已注册，请直接登录"];
            } else if (!_isRegister && !isExist) {
                [weakSelf.view hideHUD];
                [weakSelf.view kk_showAlertNoTitleWithMessage:@"手机号不存在，请注册"];
            } else {
                [KKSmsProc kk_smsSendByPhone:self.registerView.phoneTf.text completionHandler:^(NSError *error, NSString *errMsg) {
                    [weakSelf.view hideHUD];
                    if (!error) {
                        NSLog(@"发送成功");
                        KKRegisterMsgViewC *msgVC = [[KKRegisterMsgViewC alloc] initWithPhone:weakSelf.registerView.phoneTf.text title:_title];
                        [weakSelf.navigationController pushViewController:msgVC animated:YES];
                    } else {
                        NSLog(@"发送失败: %@", error);
                        [weakSelf.view kk_showAlertNoTitleWithMessage:errMsg];
                    }
                }];
            }
        } else {
            [weakSelf.view hideHUD];
            [weakSelf.view kk_showAlertNoTitleWithMessage:@"处理失败"];
        }
        
    }];
}



- (void)changeRegisterButton {
    self.registerView.registerButton.enabled = self.registerView.phoneTf.text.length == 11;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

//// 校验账号是否已注册
//[KKLoginProc kk_checkExistWithPhone:weakSelf.phoneNumber complehandler:^(BOOL isSuccessful, NSError *error, BOOL isExist) {
//    if (isSuccessful) {
//        [weakSelf.view showWarning:@"校验成功"];
//        if (isExist) {
//            [weakSelf.view kk_showAlertNoTitleWithMessage:@"该手机号已经被注册，验证码手机号后可直接登录"];
//        } else {
//            
//        }
//    } else {
//        NSLog(@"验证码校验失败");
//        [weakSelf.view kk_showAlertNoTitleWithMessage:@"验证码校验失败"];
//    }
//}];

@end
