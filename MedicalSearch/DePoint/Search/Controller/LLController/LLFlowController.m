//
//  LLFlowController.m
//  DePoint
//
//  Created by LZB on 16/8/8.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "LLFlowController.h"
#import "LLNetManager.h"
#import "ScanModel.h"
#import "LLFlowCell.h"
#import "LLScanController.h"
#import "LLIntroCell.h"

@interface LLFlowController ()
@property (nonatomic) ScanModel *model;
@end

@implementation LLFlowController
- (ScanModel *)model
{
    if (_model == nil) {
        _model = [[ScanModel alloc] init];
    }
    return _model;
}

- (instancetype)initWithStr:(NSString *)str
{
    if (self = [super init]) {
        _str = str;
        NSLog(@"%@", str);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    leftBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.title = @"查询详情";
   
    [self.tableView registerClass:[LLIntroCell class] forCellReuseIdentifier:@"Cell"];

}
- (void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
//        LLIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    
    }
    return nil;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return 200;
//    
//}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
















@end
