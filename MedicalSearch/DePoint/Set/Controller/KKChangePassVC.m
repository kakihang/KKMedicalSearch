//
//  KKChangePassVC.m
//  DePoint
//
//  Created by kaki on 16/8/16.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKChangePassVC.h"
#import "KKLoginProc.h"
#import "KKLoginRegisButton.h"

@interface KKChangePassVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView; //
@property (nonatomic, weak) UITextField *passOld; //
@property (nonatomic, weak) UITextField *passNew; //
@property (nonatomic, weak) UITextField *passNewVerify; //
@property (nonatomic, weak) KKLoginRegisButton *verifyButton; //
@end

@implementation KKChangePassVC {
    CGFloat _rowHeight;
    CGFloat _row;
    CGFloat _margin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"我的信息" tintColor:KKGLOTINTCOLOR backgroundColor:[UIColor clearColor]];
    [self setNavBottmLinehidden:YES];
    [self.view kk_viewWithVisualEffName:@"130313604324531250"];
    _rowHeight = KKScreenHeightPrecent(0.06);
    _row = 4;
    _margin = KKScreenWidthPrecent(0.1);
    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - value change 
- (void)textFieldValueChange {
    if (!_passNew || !_passOld || !_passNewVerify || !_verifyButton) {
        return;
    }
    _verifyButton.enabled = [_passNew hasText] && [_passNewVerify hasText]/* && [_passOld hasText]*/;
}

#pragma mark - click button 
- (void)clickVerifyButton {
    [self.view showHUD];
    if (![_passNew.text isEqualToString:_passNewVerify.text]) {
        [self.view hideHUD];
        [self.view kk_showAlertNoTitleWithMessage:@"两次输入密码不一致，请确认"];
    } else {
        __weak typeof(self) weakSelf = self;
        [KKLoginProc kk_changeUserPasswordWithOldPass:_passOld.text newPass:_passNewVerify.text complehandler:^(NSError *error, NSString *errMsg) {
            [weakSelf.view hideHUD];
            if (!error) {
                [weakSelf.view showWarning:@"修改成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                NSLog(@"error: %@", error);
                [weakSelf.view kk_showAlertNoTitleWithMessage:errMsg];
            }
        }];
    }
}


#pragma mark - table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellId"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger row = indexPath.row;
    UIView *view;
    if (row == 0 || row == 1 || row == 2) {
        UITextField *textf = [[UITextField alloc] init];
        [cell.contentView addSubview:textf];
        textf.secureTextEntry = YES;
        textf.clearButtonMode = UITextFieldViewModeWhileEditing;
        textf.font = [UIFont systemFontOfSize:15];
        [textf addTarget:self action:@selector(textFieldValueChange) forControlEvents:UIControlEventAllEditingEvents];
        view = textf;
        if (row == 0) {
            textf.placeholder = @"请输入当前密码";
            _passOld = textf;
        } else if (row == 1) {
            textf.placeholder = @"请输入新密码";
            _passNew = textf;
        } else {
            textf.placeholder = @"请再次输入新密码";
            _passNewVerify = textf;
        }
    } else {
        KKLoginRegisButton *login = [KKLoginRegisButton kk_buttonWithType:UIButtonTypeRoundedRect title:@"确认提交"];
        login.titleLabel.font = [UIFont systemFontOfSize:15];
        [cell.contentView addSubview:login];
        [login addTarget:self action:@selector(clickVerifyButton) forControlEvents:UIControlEventTouchUpInside];
        view = login;
        _verifyButton = login;
    }
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_margin);
        make.right.mas_equalTo(-_margin);
        make.top.bottom.mas_equalTo(0);
    }];
    return cell;
}



#pragma mark - 懒加载
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.rowHeight = _rowHeight;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(KKScreenHeightPrecent(0.9));
        }];
    }
    return _tableView;
}

@end
