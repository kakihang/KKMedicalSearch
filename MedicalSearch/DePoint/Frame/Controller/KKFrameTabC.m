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



@implementation KKFrameTabC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 修改tabBar的渲染颜色
    self.tabBar.barTintColor = KKGLOBARCOLOR;
    self.tabBar.tintColor = KKGLOTINTCOLOR;
    
    // 统一设置所有UITabBarItem属性
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSFontAttributeName:KKTabBarTextFont} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSFontAttributeName:KKTabBarTextFont} forState:UIControlStateSelected];
    
    // 添加yaopin搜索子控制器
    [self setupViewController:[[KKSearchVC alloc] init]
                     navTitle:@"搜索"
                  tabBarTitle:@"搜索"
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
    
    UINavigationController *nav;
    if ([viewController isKindOfClass:[KKSetVCtrl class]]) {
        // 使用自定义导航栏
        nav = [self setupCustomNav:(KKCustomVC *)viewController title:navTitle];
    } else {
        nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        viewController.navigationController.navigationBar.barTintColor = KKGLOBARCOLOR;
        viewController.navigationItem.title = navTitle;
    }
    
    viewController.tabBarItem.title = tabBarTitle;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    // 添加子控制器
    [self addChildViewController:nav];
}

- (KKCustomNavigationC *)setupCustomNav:(KKCustomVC *)vc title:(NSString *)title {
    // 这是自定义导航栏,C和子C使用的导航栏是分开的 _kk
    KKCustomNavigationC *nav = [[KKCustomNavigationC alloc] initWithRootViewController:vc];
    [vc setNavBarTitle:title];
    [vc setNabbarBackgroundColor:KKGLOBARCOLOR];
    return nav;
}


@end
