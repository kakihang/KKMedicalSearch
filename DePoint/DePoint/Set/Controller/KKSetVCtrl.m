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
#import "KKSetLoginTVCell.h"
#import "KKLoginViewC.h"   // 登录
#import "KKAboutViewC.h"   // 关于
#import "KKSquareButton.h" // 上图下文 按钮
#import "KKLoginProc.h"
#import "KKLoginInfoVC.h"
#import "UIImage+KKUserHeadImage.h"
#import "KKUserFileProc.h"


@interface KKSetVCtrl() <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) KKSetViewModel *setViewModel;
@property (nonatomic, weak) UIImageView *iconView; // 登录头像
@property (nonatomic, weak) UILabel *loginTitle; // title
@property (nonatomic, strong) UITableView *tableView;  // tableView
@end


@implementation KKSetVCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-15, 0, 0, 0);
    self.tableView.sectionFooterHeight = 15;
    self.tableView.sectionHeaderHeight = 0;
    
    NSLog(@"%@", KKCACHEPATH);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *user = [KKLoginProc kk_getCurrentUser];
    _loginTitle.text = user.length>0 ? user : @"点击登录";
    [_iconView setImage:[UIImage kk_getLoginUserIconWithFlag:user]];
    [self.tableView reloadData];
}


#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.setViewModel getSectionNum];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.setViewModel getRowBySection:section];
}

static NSString *cellSetId = @"KKSetVCtrlCellSetId";
static NSString *cellLoginId = @"KKSetVCtrlCellLoginId";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        KKSetLoginTVCell *cell = [tableView dequeueReusableCellWithIdentifier:cellLoginId];
        if (!cell) {
            cell = [KKSetLoginTVCell cellWithIdentifier:cellLoginId];
            _iconView = cell.iconView;
            _loginTitle = cell.loginTitle;
            NSString *user = [KKLoginProc kk_getCurrentUser];
            _loginTitle.text = user.length>0 ? user : @"点击登录";
            _iconView.image = [UIImage kk_getLoginUserIconWithFlag:user];
        }
        return cell;
    } else {
        KKSetTViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSetId];
        if (!cell) {
            cell = [KKSetTViewCell cellWithIdentifier:cellSetId];
        }
        cell.iconView.image = [self.setViewModel getIconByIndexPath:indexPath];
        cell.titleLa.text = [self.setViewModel getTitleByIndexPath:indexPath];
        cell.assistLa.text = [self.setViewModel getAssistByIndexPath:indexPath];
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    KKSetViewModelBlock run = [self.setViewModel getBlock:indexPath];
    !run?:run(self);
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return KKScreenHeightPrecent(0.12);
    } else {
        return KKScreenHeightPrecent(0.066);
    }
}


#pragma mark - 登录处理

#pragma mark - 懒加载

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}


- (KKSetViewModel *)setViewModel {
    if(_setViewModel == nil) {
        _setViewModel = [[KKSetViewModel alloc] init];
    }
    return _setViewModel;
}

@end





