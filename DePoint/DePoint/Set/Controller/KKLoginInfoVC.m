//
//  KKLoginInfoVC.m
//  DePoint
//
//  Created by kaki on 16/8/15.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKLoginInfoVC.h"
#import "KKLoginProc.h"
#import "UIImage+KKUserHeadImage.h"
#import "KKChangePassVC.h"
#import "KKRegisterViewC.h"
#import "KKUserFileProc.h"

@interface KKLoginInfoVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView; //
@property (nonatomic, weak) UILabel *userNameLabel;
@end

@implementation KKLoginInfoVC {
    NSString *_phone;
    CGFloat _rowHeight;
    CGFloat _row;
    CGFloat _rightMargin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"我的信息" tintColor:KKGLOTINTCOLOR backgroundColor:[UIColor clearColor]];
    [self setNavBottmLinehidden:YES];
    [self.view kk_viewWithVisualEffName:@"130313604324531250"];
    _rowHeight = KKScreenHeightPrecent(0.08);
    _row = 4;
    _rightMargin = KKScreenWidthPrecent(0.005);
    _phone = [KKLoginProc kk_getCurrentPhone].kk_phoneEncrypt;
    [self tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickLogoutButton {
    __weak typeof(self) weakSelf = self;
    [KKAlertWithVerifyAndCancel kk_alertWithDelegate:self title:@"确定退出？" message:nil verifyhandler:^(UIAlertController *alert) {
        [KKLoginProc kk_logout];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } cancelhandler:nil completion:nil];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _phone?_row:_row-2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"kkcellid"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    NSInteger row = indexPath.row;
    if (row == 0) {
        [cell.textLabel setText:@"头像"];
        UIImageView *icon = [UIImageView kk_imageWithImage:[UIImage kk_getLoginUserIconWithFlag:[KKLoginProc kk_getCurrentUser]] mode:UIViewContentModeScaleAspectFit radius:(_rowHeight-10)/2];
        [cell.contentView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-_rightMargin);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(_rowHeight-10);
            make.width.mas_equalTo(icon.mas_height);
        }];
    } else if (row == 1) {
        [cell.textLabel setText:[KKLoginProc kk_getCurrentUser]];
        cell.detailTextLabel.text = @"修改";
        _userNameLabel = cell.textLabel;
    } else if (row == 2) {
        [cell.textLabel setText:@"修改账号密码"];
        cell.detailTextLabel.text = @"修改";
    } else {
        [cell.textLabel setText:_phone?[NSString stringWithFormat:@"已绑定手机号%@", _phone]:@"未绑定手机号"];
    }
    [cell kk_addBottomLine];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0) {
        [KKUserFileProc kk_getUserIcon:nil];
    } else if (row == 1) {
        [KKAlertWithVerifyAndCancel kk_alertWithDelegate:self title:@"修改账号" message:nil verifyTitle:@"确认修改" verifyhandler:^(UIAlertController *alert) {
            [tableView showHUD];
            [KKLoginProc kk_changeUserName:[alert.textFields firstObject].text complehandler:^(NSError *error) {
                [tableView hideHUD];
                if (!error) {
                    NSLog(@"更新成功: %@", [alert.textFields firstObject].text);
                    [tableView showWarning:@"更新成功"];
                    [_userNameLabel setText:[KKLoginProc kk_getCurrentUser]];
                } else {
                    [tableView kk_showAlertNoTitleWithMessage:@"更新失败"];
                }
            }];
        } cancelTitle:@"取消" cancelhandler:nil texthandler:^(UITextField *text) {
            text.text = [KKLoginProc kk_getCurrentUser];
        } completion:nil];
    } else if (row == 2) {
        if (!_phone) {
            [self.view kk_showAlertNoTitleWithMessage:@"你的账号还为设置密码,请进行手机绑定并设置密码"];
        } else {
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:[[KKChangePassVC alloc] init] animated:YES];
        }
    } else {
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(KKScreenHeightPrecent(0.9));
        }];
        
        UIButton *logout = [UIButton kk_buttonWithTitle:@"退出当前登录"];
        [self.view addSubview:logout];
        [logout mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(_rowHeight);
        }];
        [logout addTarget:self action:@selector(clickLogoutButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tableView;
}

@end
