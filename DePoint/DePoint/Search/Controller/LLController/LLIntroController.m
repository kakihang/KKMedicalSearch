//
//  LLIntroController.m
//  DePoint
//
//  Created by LZB on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "LLIntroController.h"
#import "LLNetManager.h"
#import "LLIntroCell.h"
#import "LLScanController.h"
#import "LLIntroBelowCell.h"
#import "LLScanningModel.h"



@interface LLIntroController ()

@property(nonatomic)Esarray *model;
@property(nonatomic) NSString *viewLb;
@property (nonatomic) NSString *normstext;//【规格】
@property (nonatomic) NSString *ratifytext;//【批准文号】
@property (nonatomic) NSString *packtext;//【包装】
@property (nonatomic) NSString *elementtext;//【成份】

@end

@implementation LLIntroController

- (Esarray *)model {
    if(_model == nil) {
        _model = [[Esarray alloc] init];
    }
    return _model;
}

- (instancetype)initWithStr:(NSString *)str
{
    if (self = [super init]) {
        _str = str;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftItem)];
    leftBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.title = @"查询详情";
    self.view.backgroundColor=[UIColor redColor];
    [self.tableView registerClass:[LLIntroCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[LLIntroBelowCell class] forCellReuseIdentifier:@"cell"];
    
    __weak typeof(self) weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        [LLNetManager getCode:weakSelf.str completionHandler:^(Esarray *model, NSError *error) {
            [weakSelf.tableView endHeaderRefresh];
            weakSelf.model = model;
            [weakSelf.tableView reloadData];
        }];
    }];
    [weakSelf.tableView beginHeaderRefresh];
    
}

- (void)clickLeftItem
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
    
        LLIntroCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
        /*
         @property (nonatomic) UIImageView *fixed;//固定图
         @property (nonatomic) UILabel *nameLb;//药品名字
         @property (nonatomic) UILabel *millLb;//制造工厂
         @property (nonatomic) UILabel *codeLb;//13位条形码
         @property (nonatomic) UILabel *informationLb;//消息标题
         @property (nonatomic) UIButton *details;//详情按钮

         */
        Cell.fixed.image = [UIImage imageNamed:@"fixed"];
//        Cell.fixed.contentMode = UIViewContentModeCenter;
//        Cell.nameLb.text = self.model.drugName;
//        Cell.millLb.text = self.model.goodsManu;
    
//        [Cell.details.layer setMasksToBounds:YES];
//        [Cell.details.layer setCornerRadius:10.0];
//        Cell.details.titleLabel.textColor = [UIColor blackColor];

        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return Cell;
//    }else{
//        LLIntroBelowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//
////        cell.division.backgroundColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
//        return cell;
//    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;

}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
@end
