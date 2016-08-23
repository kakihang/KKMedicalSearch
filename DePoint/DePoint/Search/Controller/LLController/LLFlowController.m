//
//  LLFlowController.m
//  DePoint
//
//  Created by LZB on 16/8/8.
//  Copyright © 2016年 liudhkk. All rights reserved.
//
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#import "LLFlowController.h"
#import "LLNetManager.h"
#import "ScanModel.h"
#import "LLScanController.h"
#import "LLIntroCell.h"
#import "KKSearchMsgTVCell.h"

@interface LLFlowController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) ScanModel *model;
@property (nonatomic) UITableView *leftTable;
@property (nonatomic) UIView *rightTable;
@property (nonatomic) NSArray<NSMutableAttributedString*> *arr;
@property (nonatomic) NSArray *goarr;

@property (nonatomic, weak) UIView *newsView;
@property (nonatomic, weak) UIView *flowView;

@end



@implementation LLFlowController
- (ScanModel *)model {
    if(_model == nil) {
        _model = [[ScanModel alloc] init];
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
    self.view.backgroundColor = KKGlobalControllerBackgroundColor;
    //    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    //    leftBtn.tintColor = [UIColor whiteColor];
    //    self.navigationItem.leftBarButtonItem = leftBtn;
    //    self.navigationItem.title = @"查询详情";
    
    [self.tableView registerClass:[LLIntroCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[KKSearchMsgTVCell class] forCellReuseIdentifier:@"Acell"];
    
    __weak typeof(self) weakSelf = self;
    //    [self.tableView addHeaderRefresh:^{
    [LLNetManager getcode:weakSelf.str completionHandler:^(ScanModel *model, NSError *error) {
        weakSelf.model = model;
        weakSelf.arr = [[NSArray alloc] initWithObjects:
                        [weakSelf text:@"药品流向:  " and:weakSelf.model.info.status],
                        [weakSelf text:@"生产批次:  " and:weakSelf.model.info.production_batch],
                        [weakSelf text:@"生产日期:  " and:weakSelf.model.info.production_date],
                        [weakSelf text:@"剂型代码:  " and:weakSelf.model.info.prepn_type],
                        [weakSelf text:@"制剂规格:  " and:weakSelf.model.info.specifications],
                        [weakSelf text:@"制剂单位:  " and:weakSelf.model.info.pkg_unit],
                        [weakSelf text:@"包装规格:  " and:weakSelf.model.info.pkg_spec],
                        [weakSelf text:@"药品类别:  " and:weakSelf.model.info.category],
                        [weakSelf text:@"批准文号:  " and:weakSelf.model.info.license_number],
                        [weakSelf text:@"批准文号有效期:  " and:weakSelf.model.info.issue_expiry],nil];
        
        weakSelf.goarr = [[NSArray alloc] initWithObjects:
                          [UIImage imageNamed:@"shengchan"],
                          [UIImage imageNamed:@"xia"],
                          [UIImage imageNamed:@"qiche"],
                          [UIImage imageNamed:@"xia"],
                          [UIImage imageNamed:@"dianpu"],
                          [UIImage imageNamed:@"xia"],
                          [UIImage imageNamed:@"wode"],nil];
        [weakSelf.tableView reloadData];
        //        [weakSelf.tableView endHeaderRefresh];
    }];
    //    }];
    //    [weakSelf.tableView beginHeaderRefresh];
}
- (void)back
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LLIntroCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
        Cell.fixed.image = [UIImage imageNamed:@"fixed"];
        Cell.fixed.contentMode = UIViewContentModeScaleAspectFill;
        NSString *flow = [self.model.info.flow stringByReplacingOccurrencesOfString:@"," withString:@""];
        Cell.nameLb.text = self.model.info.title;
        Cell.millLb.text = flow;
        Cell.codeLb.text = [NSString stringWithFormat:@"监管码:\n%@", self.model.info.code];
        Cell.codeLb.numberOfLines = 0;
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [Cell.btn addTarget:self action:@selector(selected:)forControlEvents:UIControlEventValueChanged];
        
        return Cell;
        
    }else {
        
        KKSearchMsgTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Acell" forIndexPath:indexPath];
        [cell.flowDirection.detailsLb enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.attributedText=self.arr[idx];
        }];
        self.newsView = cell.flowDirection;
        self.newsView.hidden = NO;
        
        cell.infoView.inquiry.text = [NSString stringWithFormat:@"该监管码已被查询%ld次", (long)self.model.info.query_time];
        cell.infoView.time.text = [NSString stringWithFormat:@"首次查询时间：%@", self.model.info.last_time];
        [cell.infoView.go enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.image = self.goarr[idx];
        }];
        self.flowView = cell.infoView;
        self.flowView.hidden = YES;
        
        //        cell.userInteractionEnabled = NO;
        
        return cell;
    }
}


-(void)selected:(id)sender{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    switch (control.selectedSegmentIndex) {
        case 0: {
            self.newsView.hidden = NO;
            self.flowView.hidden = YES;
        }
            break;
        case 1: {
            self.newsView.hidden = YES;
            self.flowView.hidden = NO;
        }
            
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 190;
    }
    return 400;
}

-(NSMutableAttributedString*)text:(NSString*)stra and:(NSString*)strb{
    NSAttributedString *strc=[[NSAttributedString alloc]initWithString:stra attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    NSAttributedString *strd=[[NSAttributedString alloc]initWithString:strb attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *str=[NSMutableAttributedString new];
    [str appendAttributedString:strc];
    [str appendAttributedString:strd];
    return str;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}





@end
