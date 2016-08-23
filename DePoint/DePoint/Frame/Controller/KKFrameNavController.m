//
//  KKFrameNavController.m
//  DePoint
//
//  Created by kaki on 16/8/22.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKFrameNavController.h"

@interface KKFrameNavController ()

@end

@implementation KKFrameNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 可以在这个方法中拦截所有push进来的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    if (self.childViewControllers.count > 0) {
        //        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        
        //        [button setTitle:@"返回" forState:UIControlStateNormal];
        //        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        //        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        //        button.size = CGSizeMake(70, 30);
        //        
        //        //        [button sizeToFit];
        //        // 设置内容向左边靠
        //        // 内容水平对齐-》向左
        //        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        
        //        // 设置文字颜色
        //        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        //        
        //        // 增加点击事件
        //        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //        
        
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] bk_initWithTitle:@"《 返回" style:UIBarButtonItemStylePlain handler:^(id sender) {
            [viewController.navigationController popViewControllerAnimated:YES];
        }];
        back.tintColor = KKGlobalTextWhiteColor;
        viewController.navigationItem.leftBarButtonItem = back;
        //                viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // 隐藏tabBar
        //        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句super要放在最后，这样可以让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
}

@end
