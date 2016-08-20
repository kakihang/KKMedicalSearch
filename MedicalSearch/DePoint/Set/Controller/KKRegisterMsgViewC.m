//
//  KKRegisterMsgViewC.m
//  DePoint
//
//  Created by kaki on 16/8/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKRegisterMsgViewC.h"
#import "KKRegisterShowView.h"
#import "KKRegisterPassViewC.h"
#import "KKSmsProc.h"
#import "KKLoginProc.h"

@interface KKRegisterMsgViewC ()
@property (nonatomic, strong) NSString *phoneNumber; //
@property (nonatomic, strong) KKRegisterShowView *registerView; //
@end

@implementation KKRegisterMsgViewC {
    NSInteger _sec;
    NSString *_title;
}

- (instancetype)initWithPhone:(NSString *)phone title:(NSString *)title {
    if (self = [super init]) {
        _title = title;
        _phoneNumber = phone;
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
    self.registerView = [KKRegisterShowView registerShowOnView:self.view index:1];
    
    if (self.registerView.showPhoneLa) {
        NSString *msg = [NSString stringWithFormat:@"%@%@           ",
                         self.registerView.showPhoneLa.text, self.phoneNumber.kk_phoneEncrypt];
        self.registerView.showPhoneLa.text = msg;
    }
    
    self.registerView.phoneTf.placeholder = @"请输入短信中的验证码";
    [self.registerView.phoneTf addTarget:self action:@selector(textValueChange) forControlEvents:UIControlEventAllEditingEvents];
    
    [self.registerView.sendAgain addTarget:self action:@selector(clickSendAgain) forControlEvents:UIControlEventTouchUpInside];
    [self setSendAgainButton];
    
    self.registerView.registerButton.enabled = NO;
    [self.registerView.registerButton setTitle:@"提交验证码" forState:UIControlStateNormal];
    [self.registerView.registerButton addTarget:self action:@selector(clickRegisterMsgButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - 短信重发处理

- (void)clickSendAgain {
    NSLog(@"%s", __func__);
    [self.view showHUD];
    __weak typeof(self) weakSelf = self;
    [KKSmsProc kk_smsSendByPhone:_phoneNumber completionHandler:^(NSError *error, NSString *errMsg) {
        [weakSelf.view hideHUD];
        if (!error) {
            NSLog(@"发送成功");
            [weakSelf.view showWarning:@"发送成功"];
        } else {
            [weakSelf.view kk_showAlertNoTitleWithMessage:errMsg];
        }
    }];
    [self setSendAgainButton];
}


- (void)setSendAgainButton {
    _sec = KKSendMsgWaitSec;
    self.registerView.sendAgain.enabled = NO;
    [self runSecond:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runSecond:) userInfo:nil repeats:YES];
}

- (void)runSecond:(NSTimer *)timer {
    if (_sec <= 0) {
        [self.registerView.sendAgain setTitle:@"重获验证码" forState:UIControlStateNormal];
        [timer invalidate];
        self.registerView.sendAgain.enabled = YES;
        return;
    }
    [self.registerView.sendAgain setTitle:[NSString stringWithFormat:@"%zd%@", _sec--, @"s后重新发送"] forState:UIControlStateNormal];
}

#pragma mark - text field value change
- (void)textValueChange {
    self.registerView.registerButton.enabled = (self.registerView.phoneTf.text.length == 4 || self.registerView.phoneTf.text.length == 6);
}

#pragma mark - 登录
- (void)clickRegisterMsgButton {
    [self.view showHUD];
    __weak typeof(self) weakSelf = self;
    NSString *smsCode = self.registerView.phoneTf.text;
    [KKSmsProc kk_smsCheckByPhone:_phoneNumber smsCode:smsCode completionHandler:^(NSError *error, NSString *errMsg) {
        [weakSelf.view hideHUD];
        if (!error) {
            NSLog(@"校验成功");
            [self.navigationController pushViewController:[[KKRegisterPassViewC alloc]initWithPhone:_phoneNumber title:_title] animated:YES];
        } else {
            NSLog(@"校验失败");
            [weakSelf.view kk_showAlertNoTitleWithMessage:errMsg];
        }
    }];
}



@end
