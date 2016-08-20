//
//  KKCustomVC.h
//  DeliveryPoint
//
//  Created by kaki on 16/7/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//  

#import <UIKit/UIKit.h>
#import "KKCustomNavBarV.h"
#import "KKCustomNavigationC.h"

@interface KKCustomVC : UIViewController

@property (nonatomic, weak) KKCustomNavBarV *navbar;

// 设置导航栏在最上层
- (void)bringNavBarToTopmost;

// 是否隐藏导航栏
- (void)hideNavBar:(BOOL)bIsHide;

// 设置STNavBarView 颜色 _kk
- (void)setNabbarBackgroundColor:(UIColor *)color;
- (void)setNavTitle:(NSString *)title tintColor:(UIColor *)tintColor backgroundColor:(UIColor *)bgColor;

// 隐藏导航栏分割线
- (void)setNavBottmLinehidden:(BOOL)hide;

// 设置导航栏渲染颜色
- (void)setNavBarTintColor:(UIColor *)color;

// 设置标题
- (void)setNavBarTitle:(NSString *)strTitle;

// add by kaki 夜间颜色设置
//- (void)setNavBarTitleDKColor:(id)dkColor;

// 设置导航栏左按钮
- (void)setNavBarLeftBtn:(UIButton *)btn;

// 设置导航栏右按钮
- (void)setNavBarRightBtn:(UIButton *)btn;

// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)canDragBack;


// 重设scroll view的内容区域和滚动条区域
- (void)resetScrollView:(UIScrollView *)scrollView tabBar:(BOOL)hasTabBar;
@end
