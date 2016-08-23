//
//  KKFrameTabC.m
//  DePoint
//
//  Created by kaki on 16/7/22.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKFrameTabC.h"

#import "KKDisVCtrl.h"
#import "KKNearVCtrl.h"
#import "KKSetVCtrl.h"
#import "KKSearchVC.h"
#import "XPMediController.h"

#import "KKFrameNavController.h"

@implementation KKFrameTabC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 修改tabBar的渲染颜色
    self.tabBar.barTintColor = KKGLOBAL; // 背景渲染
    self.tabBar.tintColor = KKGlobalViewColor; // 图片文字子view渲染
    
    // 统一设置所有UITabBarItem属性
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSFontAttributeName:KKTabBarTextFont} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSFontAttributeName:KKTabBarTextFont} forState:UIControlStateSelected];
    
    // 添加yaopin搜索子控制器
    [self setupViewController:[[KKSearchVC alloc] init]
                     navTitle:@"扫描"
                  tabBarTitle:@"扫描"
                        image:KKIMAGE(@"sear")
                selectedImage:KKIMAGE(@"sear")];
    
    // 添加yaopin分类子控制器
    [self setupViewController:[[XPMediController alloc] initWithStyle:UITableViewStyleGrouped]
                     navTitle:@"发现"
                  tabBarTitle:@"发现"
                        image:KKIMAGE(@"dis")
                selectedImage:KKIMAGE(@"dis")];
    
    // 添加附近子控制器
    [self setupViewController:[[KKNearVCtrl alloc] init]
                     navTitle:@"附近"
                  tabBarTitle:@"附近"
                        image:KKIMAGE(@"near")
                selectedImage:KKIMAGE(@"near")];
    
    // 添加附近子控制器
    [self setupViewController:[[KKSetVCtrl alloc] init]
                     navTitle:@"我的"
                  tabBarTitle:@"我的"
                        image:KKIMAGE(@"set")
                selectedImage:KKIMAGE(@"set")];
}




- (void)setupViewController:(UIViewController *)viewController
                   navTitle:(NSString *)navTitle
                tabBarTitle:(NSString *)tabBarTitle
                      image:(UIImage *)image
              selectedImage:(UIImage *)selectedImage {
    
    /** 统一设置子控制器底色、导航栏颜色 **/
    // 如有特殊需求请求具体子控制器内修改
    viewController.view.backgroundColor = KKGLOBAL; //全局颜色 238,238,238,1 _kk
    
    KKFrameNavController *nav = [[KKFrameNavController alloc] initWithRootViewController:viewController];
    // 导航栏设置
    viewController.navigationItem.title = navTitle;
    viewController.navigationController.navigationBar.barTintColor = KKGlobalViewColor;
    viewController.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [viewController.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:KKNavMainTitleTextFont, NSForegroundColorAttributeName:KKGlobalTextWhiteColor}];
    // 底部tabBar设置
    viewController.tabBarItem.title = tabBarTitle;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selectedImage;
    //    viewController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; // 使用原色
    
    
    // 添加子控制器
    [self addChildViewController:nav];
}



@end
