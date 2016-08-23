//
//  KKSearchVC.m
//  DePoint
//
//  Created by kaki on 16/8/17.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKSearchVC.h"

#import "LLScanController.h"
#import "LLIntroController.h"
#import "LLFlowController.h"
@implementation KKSearchVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KKGlobalControllerBackgroundColor;
    [self setupView];
}

- (void)setupView {
    CGFloat bgViewHeight = KKScreenHeightPrecent(0.6);
    CGFloat scanfTopMargin = bgViewHeight * 0.1 + 64;
    CGFloat scanfHeight = bgViewHeight * 0.6;
    CGFloat historyLeftMargin = KKScreenWidthPrecent(0.045);
    CGFloat historyBottonMargin = KKScreenHeightPrecent(0.02);
    CGFloat historyWidth = KKScreenWidthPrecent(0.3);
    CGFloat historyHeight = KKScreenHeightPrecent(0.05);
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KKSCREENBOUNDSIZE.width, bgViewHeight)];
    [self.view addSubview:bgView];
    bgView.backgroundColor = KKCOLOR(201, 223, 238, 1.0);
    
    // 扫描按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:btn];
    [btn addTarget:self action:@selector(move) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"scanf"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"scanf"] forState:UIControlStateHighlighted];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(scanfTopMargin);
        make.size.mas_equalTo(CGSizeMake(scanfHeight, scanfHeight));
    }];
    
    UIImageView *historyView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"history"]];
    [bgView addSubview:historyView];
    [historyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(historyLeftMargin);
        make.bottom.mas_equalTo(-historyBottonMargin);
        make.size.mas_equalTo(CGSizeMake(historyWidth, historyHeight));
    }];
}

-(void)move{
    LLScanController *code = [LLScanController new];
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:code];
    [self.navigationController pushViewController:code animated:YES];
    
}

@end