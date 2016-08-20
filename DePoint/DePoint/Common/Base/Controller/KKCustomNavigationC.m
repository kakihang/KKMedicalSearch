//
//  KKCustomNavigationC.m
//  DeliveryPoint
//
//  Created by kaki on 16/7/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKCustomNavigationC.h"

@interface KKCustomNavigationC ()

@end

@implementation KKCustomNavigationC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 使导航条有效
    [self setNavigationBarHidden:NO];
    
    // 隐藏导航条，但由于导航条有效，系统的返回按钮页有效，所以可以使用系统的右滑返回手势。
    [self.navigationBar setHidden:YES];
    
    // 默认可滑动
    [self navigationCanDragBack:YES];
}

// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)canDragBack
{
    self.interactivePopGestureRecognizer.enabled = canDragBack;
}



@end
