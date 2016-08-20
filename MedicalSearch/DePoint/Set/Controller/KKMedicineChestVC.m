//
//  KKMedicineChestVC.m
//  DePoint
//
//  Created by kaki on 16/8/18.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKMedicineChestVC.h"

@interface KKMedicineChestVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView; //
@property (nonatomic, strong) NSArray *dataList; //
@end

@implementation KKMedicineChestVC

static NSString *cellID_ = @"KKMedicineChestVCCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"药箱" tintColor:KKGLOTINTCOLOR backgroundColor:KKGLOBARCOLOR];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID_];
    [self setupNavButton];
}

- (void)setupNavButton {
    UIButton *edit = [UIButton kk_buttonWithTitle:@"编辑"];
    edit.frame = CGRectMake(0, 0, 44, 44);
    [self setNavBarRightBtn:edit];
    [edit bk_addEventHandler:^(id sender) {
        
        for (int i=0; i<5; i++) {
            KKMedicineDataModel *model = [[KKMedicineDataModel alloc] init];
            model.userName = @"091";
            model.identifier = [NSString stringWithFormat:@"0004567890%d", i];
            if (i == 0) {
                model.text = @"ni";
                model.detailText = @"aaaa";
                model.icon = @"http://cdn-img.easyicon.net/png/11816/1181620.gif";
            } else if (i == 1) {
                model.text = @"bvb";
                model.detailText = @"pppo";
                model.icon = @"http://cdn-img.easyicon.net/png/11816/1181622.gif";
            } else {
                model.text = @"aaaa";
                model.detailText = @"ppo";
                model.icon = @"http://cdn-img.easyicon.net/png/11816/1181630.gif";
                model.reamrk = @"记录";
            }
            //            [KKMEDICINEDATA kk_saveSanBoxWithDataModel:model];
            [KKMEDICINEDATA kk_saveMedicineChestWithModel:model complectionHandler:^(NSError *error, NSString *errMsg) {
                if (error) {
                    NSLog(@"保存失败 %@", model.identifier);
                }
            }];
        }
        
//        NSArray *arr = [KKMEDICINEDATA kk_getSanBoxWithUserName:@"090"];
//        NSLog(@"0000---%zd", arr.count);
//        [arr enumerateObjectsUsingBlock:^(KKMedicineDataModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSLog(@"%@ %@ %@ %@ %@ %@", obj.userName, obj.identifier, obj.saveDate, obj.text, obj.detailText, obj.icon);
//        }];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID_ forIndexPath:indexPath];
    
    return cell;
}


#pragma mark - 懒加载
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (NSArray *)dataList {
    if(_dataList == nil) {
        _dataList = [[NSArray alloc] init];
    }
    return _dataList;
}

@end
