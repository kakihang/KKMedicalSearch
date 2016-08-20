//
//  XPFactory.m
//  DePoint
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPFactory.h"

@implementation XPFactory
+(void)addSearchItemForVC:(UIViewController *)vc clickedHandler:(void (^)())handler{
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbtn setImage:[UIImage imageNamed:@"搜索_默认"] forState:UIControlStateNormal];
    [backbtn setImage:[UIImage imageNamed:@"搜索_按下"] forState:UIControlStateHighlighted];
    backbtn.frame = CGRectMake(0, 0, 44, 44);
    [backbtn bk_addEventHandler:^(id sender) {
        !handler ? :handler();
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    vc.navigationItem.rightBarButtonItems = @[spaceItem,backItem];
}

@end
