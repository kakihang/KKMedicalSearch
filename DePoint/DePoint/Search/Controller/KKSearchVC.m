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
@implementation KKSearchVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame=CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"扫描" forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor blackColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(move) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame=CGRectMake(200, 200, 100, 100);
    [btn1 setTitle:@"扫描" forState:UIControlStateNormal];
    btn1.backgroundColor=[UIColor blackColor];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(move) forControlEvents:UIControlEventTouchUpInside];
}

-(void)move{
    //    LLScanController *code = [LLScanController new];
    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:code];
    //    [self presentViewController:nav animated:YES completion:nil];
    
    LLIntroController *vc = [[LLIntroController alloc] initWithStr:@"6900508175702"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end