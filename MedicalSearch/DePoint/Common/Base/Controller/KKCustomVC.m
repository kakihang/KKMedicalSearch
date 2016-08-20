//
//  KKCustomVC.m
//  DeliveryPoint
//
//  Created by kaki on 16/7/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKCustomVC.h"
#import "KKCustomNavBarV.h"

@interface KKCustomVC ()

@end

@implementation KKCustomVC


- (void)dealloc
{
    if (self)
    {
        //取消延迟执行
        [[KKCustomVC class] cancelPreviousPerformRequestsWithTarget:self];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    KKCustomNavBarV *navbar = [[KKCustomNavBarV alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [KKCustomNavBarV barSize].width, [KKCustomNavBarV barSize].height)];
    _navbar = navbar;
    _navbar.viewCtrlParent = self;
    [self.view addSubview:_navbar];
    //设置导航栏背景颜色
    [self setNabbarBackgroundColor:[UIColor whiteColor]];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_navbar && !_navbar.hidden)
    {
        [self.view bringSubviewToFront:_navbar];
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark -
- (void)bringNavBarToTopmost
{
    if (_navbar)
    {
        [self.view bringSubviewToFront:_navbar];
    }
}


// 设置KKCustomNavBarV 颜色
- (void)setNabbarBackgroundColor:(UIColor *)color
{
    if (_navbar) {
        [_navbar setBackgroundColor:color];
    }
}
// _kk
- (void)setNavBarTintColor:(UIColor *)color {
    if (_navbar) {
        [_navbar setNavTintColor:color];
    }
}
// _kk
- (void)setNavBottmLinehidden:(BOOL)hide {
    if (_navbar) {
        [_navbar setNavBottomLineHidde:hide];
    }
}

- (void)hideNavBar:(BOOL)bIsHide
{
    _navbar.hidden = bIsHide;
}
// _kk
- (void)setNavTitle:(NSString *)title tintColor:(UIColor *)tintColor backgroundColor:(UIColor *)bgColor {
    if (title) {
        [self setNavBarTitle:title];
    }
    if (tintColor) {
        [self setNavBarTintColor:tintColor];
    }
    if (bgColor) {
        [self setNabbarBackgroundColor:bgColor];
    }
}

- (void)setNavBarTitle:(NSString *)strTitle
{
    if (_navbar)
    {
        [_navbar setTitle:strTitle];
    }
    else{
        NSLog(@"APP_ASSERT_STOP");
        NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);
    }
}


//- (void)setNavBarTitleDKColor:(id)dkColor
//{
//    if (_navbar)
//    {
//        [_navbar setTitleDKColor:dkColor];
//    }
//    else{
//        NSLog(@"APP_ASSERT_STOP");
//        NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);
//    }
//}


- (void)setNavBarLeftBtn:(UIButton *)btn
{
    if (_navbar)
    {
        [_navbar setLeftBtn:btn];
    }
    else{
        NSLog(@"APP_ASSERT_STOP");
        NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);
    }
}

- (void)setNavBarRightBtn:(UIButton *)btn
{
    if (_navbar)
    {
        [_navbar setRightBtn:btn];
    }
}


// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)canDragBack
{
    if (self.navigationController)
    {
        [((KKCustomVC *)(self.navigationController)) navigationCanDragBack:canDragBack];
    }
}


// 重设scroll view的内容区域和滚动条区域
- (void)resetScrollView:(UIScrollView *)scrollView tabBar:(BOOL)hasTabBar
{
    if (scrollView)
    {
        UIEdgeInsets inset = scrollView.contentInset;
        UIEdgeInsets insetIndicator = scrollView.scrollIndicatorInsets;
        
        CGPoint ptContentOffset = scrollView.contentOffset;
        CGFloat fTopInset = 0.0f;
        CGFloat fTopIndicatorInset = 0.0f;
        
        CGFloat fBottomInset = hasTabBar ? Bottom_H : 0.0f;
        
        fTopInset += NaviBar_H - StatusBar_H;
        fTopIndicatorInset += NaviBar_H - StatusBar_H;
        
        inset.top += fTopInset;
        inset.bottom += fBottomInset;
        
        [scrollView setContentInset:inset];
        
        insetIndicator.top += fTopIndicatorInset;
        insetIndicator.bottom += fBottomInset;
        [scrollView setScrollIndicatorInsets:insetIndicator];
        
        ptContentOffset.y -= fTopInset;
        [scrollView setContentOffset:ptContentOffset];
    }
}
@end
