//
//  KKSetVCtrl.m
//  DePoint
//
//  Created by kaki on 16/7/22.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKSetVCtrl.h"
#import "KKSetViewModel.h"
#import "KKSetTViewCell.h" //
#import "KKLoginViewC.h"   // 登录
#import "KKAboutViewC.h"   // 关于
#import "KKSquareButton.h" // 上图下文 按钮
#import "KKLoginProc.h"
#import "KKLoginInfoVC.h"
#import "UIImage+KKUserHeadImage.h"
#import "KKUserFileProc.h"


@interface KKSetVCtrl() <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) KKSetViewModel *setViewModel;
@property (nonatomic, strong) UIImageView *imageView; // 登录按钮
@property (nonatomic, strong) UITableView *tableView;  // tableView
@property (nonatomic, weak) UIButton *loginButton; //
@end


@implementation KKSetVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideNavBar:YES]; //隐藏导航栏
    
    self.tableView.contentInset = UIEdgeInsetsMake(-15, 0, 0, 0);
    self.tableView.sectionFooterHeight = 15;
    self.tableView.sectionHeaderHeight = 0;
    
    NSLog(@"%@", KKCACHEPATH);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *user = [KKLoginProc kk_getCurrentUser];
    if (user.length > 0) {
        [_loginButton setTitle:user forState:UIControlStateNormal];
    } else {
        [_loginButton setTitle:@"点击登录" forState:UIControlStateNormal];
    }
    [_loginButton setImage:[UIImage kk_getLoginUserIconWithFlag:user] forState:UIControlStateNormal];
    [self.tableView reloadData];
}


#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.setViewModel getSectionNum];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.setViewModel getRowBySection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"KKSetVCtrlCellId";
    KKSetTViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [KKSetTViewCell cellWithIdentifier:cellId];
    }
    
    cell.iconView.image = [self.setViewModel getIconByIndexPath:indexPath];
    cell.titleLa.text = [self.setViewModel getTitleByIndexPath:indexPath];
    cell.assistLa.text = [self.setViewModel getAssistByIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    KKSetViewModelBlock run = [self.setViewModel getBlock:indexPath];
    !run?:run(self);
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 登录处理
- (void)clickLoginButton {
    self.hidesBottomBarWhenPushed = YES;
    [KKLoginProc kk_getCurrentUser].length>0?[self.navigationController pushViewController:[[KKLoginInfoVC alloc] init] animated:YES]:[self.navigationController pushViewController:[[KKLoginViewC alloc] init] animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 懒加载

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (UIImageView *)imageView {
    if(_imageView == nil) {
        _imageView = [UIImageView kk_imageWithImageName:@"set_login_head" frame:CGRectMake(0, 0, KKSCREENBOUNDSIZE.width, KKSCREENBOUNDSIZE.height * 0.3) mode:UIViewContentModeCenter];
        [self.view addSubview:_imageView];
        _imageView.userInteractionEnabled = YES;
        
        CGFloat width = KKSCREENBOUNDSIZE.height * 0.13;
        CGFloat height = width + 30;
        KKSquareButton *loginBtn = [[KKSquareButton alloc] init];
        [loginBtn addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
        [_imageView addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_imageView);
            make.size.mas_equalTo(CGSizeMake(width, height));
        }];
        _loginButton = loginBtn;
    }
    return _imageView;
}

- (KKSetViewModel *)setViewModel {
    if(_setViewModel == nil) {
        _setViewModel = [[KKSetViewModel alloc] init];
    }
    return _setViewModel;
}

@end
