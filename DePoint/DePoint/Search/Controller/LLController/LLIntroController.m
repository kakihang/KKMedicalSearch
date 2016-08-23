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

@property (nonatomic) NSArray<LLScanningModel*> *model;

@end

@implementation LLIntroController

- (NSArray<LLScanningModel*> *)model {
    if(_model == nil) {
        _model = [[NSArray<LLScanningModel*> alloc] init];
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
//    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftItem)];
//    leftBtn.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.title = @"查询详情";
    [self.tableView registerClass:[LLIntroCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[LLIntroBelowCell class] forCellReuseIdentifier:@"cell"];
    
    
    __weak typeof(self) weakSelf = self;
    //    [self.tableView addHeaderRefresh:^{
    [LLNetManager getCode:weakSelf.str completionHandler:^(NSArray<LLScanningModel*> *model, NSError *error) {
        //            [weakSelf.tableView endHeaderRefresh];
        weakSelf.model = model;
        [weakSelf.tableView reloadData];
    }];
    //}];
    //    [weakSelf.tableView beginHeaderRefresh];
    
}

- (void)clickLeftItem
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.model.count == 0){
        return 0;
    }
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.model.count == 0) {
        return 0;
    }
    return self.model.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        LLIntroCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        Cell.fixed.image = [UIImage imageNamed:@"fixed"];
        Cell.fixed.contentMode = UIViewContentModeScaleAspectFill;
        Cell.nameLb.text = self.model[indexPath.row].drugName;
        Cell.millLb.text = self.model[indexPath.row].goodsManu;
        Cell.codeLb.text = [NSString stringWithFormat:@"商品码: %@",self.model[indexPath.row].barCode];
        [Cell.details setTitle:@"详情" forState:UIControlStateNormal];
        [Cell.details setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        Cell.informationLb.text = @"药品信息";
        Cell.userInteractionEnabled = NO;
        return Cell;
    }else{
        
        LLIntroBelowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.tintColor = [UIColor redColor];
        cell.division.backgroundColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
        cell.reminder.text = @"温馨提示: 您现在扫描的是商品条形码, 如扫描20位“中国药品电子监管码”, 将可能获得药品更详细信息";
        cell.formLb.text = [NSString stringWithFormat:@"性态: %@", self.model[indexPath.row].form];
        cell.packuomLb.text = [NSString stringWithFormat:@"包装: %@", self.model[indexPath.row].packUom];
        cell.standardLb.text = [NSString stringWithFormat:@"规格: %@", self.model[indexPath.row].standard];
        cell.passnumLb.text = [NSString stringWithFormat:@"批准文号: %@", self.model[indexPath.row].passNum];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.userInteractionEnabled = NO;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
