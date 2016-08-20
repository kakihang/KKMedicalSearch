//
//  XPSearchController.m
//  DePoint
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPSearchController.h"
#import "XPDetailCell.h"
#import "XPSearchModel.h"
#import "XPSearchCell.h"
@interface XPSearchController ()<UISearchBarDelegate>
@property(nonatomic) XPSearchModel *data;
@property(nonatomic) NSString *viewLb;
@property(nonatomic) NSString *name;
@end

@implementation XPSearchController
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    if(searchBar.text.length >0){
        self.name = searchBar.text;
        [self.view hideHUD];
        __weak typeof(self) weakSelf = self;
        [XPNetManager getSearch:self.name completionHandler:^(XPSearchModel *model, NSError *error) {
            [weakSelf.view hideHUD];
            weakSelf.data = model;
            [weakSelf hpple];
            [weakSelf.tableView reloadData];
        }];
    }else{
        [self.view showWarning:@"请输入搜索内容"];
    }
}
-(instancetype)initWithStyle:(UITableViewStyle)style{
    self =[super initWithStyle:style];
    if(self){
        UISearchBar *bar =[[UISearchBar alloc]init];
        bar.delegate = self;
        bar.placeholder = @"请输入搜索内容";
        self.navigationItem.titleView = bar;
        __weak typeof(self) weakSelf = self;
        [XPFactory addSearchItemForVC:self clickedHandler:^{
            [bar endEditing:YES];
            if(bar.text.length>0){
                weakSelf.name = bar.text;
                
                [weakSelf.view showHUD];
                [XPNetManager getSearch:weakSelf.name completionHandler:^(XPSearchModel *model, NSError *error) {
                    [weakSelf.view hideHUD];
                    weakSelf.data = model;
                    [weakSelf hpple];
                    [weakSelf.tableView reloadData];
                }];
            }else{
                [weakSelf.view showWarning:@"请输入搜索内容"];
            }
        }];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.height = self.tableView.bounds.size.height;
    self.tableView.scrollEnabled =NO;
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]bk_initWithTitle:@"返回" style:UIBarButtonItemStyleDone handler:^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.tableView.rowHeight = self.tableView.bounds.size.height;
    [self.tableView registerClass:[XPDetailCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[XPSearchCell class] forCellReuseIdentifier:@"textCell"];
    [self.tableView addHeaderRefresh:^{
        [XPNetManager getSearch:weakSelf.name completionHandler:^(XPSearchModel *model, NSError *error) {
            weakSelf.data = model;
            [weakSelf.tableView endHeaderRefresh];
            [weakSelf hpple];
            [weakSelf.tableView reloadData];
        }];
    }];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.data.count==0){
        return 0;
    }else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.data.count==0){
        return 0;
    }else{
        return 1;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if(indexPath.section == 0){
    //        XPDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //        [cell.iconIV setImageWithURL:[NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",self.data.img].yx_URL placeholder:[UIImage imageNamed:@"背景"]];
    //        cell.nameLb.text = self.data.name;
    //        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //        self.tableView.rowHeight = 100;
    //        return cell;
    //    }else{
    XPSearchCell *cell =[tableView dequeueReusableCellWithIdentifier:@"textCell" forIndexPath:indexPath];
    cell.textLb.text = self.viewLb;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
    //    }
}
-(void)hpple{
    NSString  *html = self.data.message;
    
    NSMutableString *mustring = html.mutableCopy;
    while (1) {
        NSRange rang = [mustring rangeOfString:@"⏎"];
        if(rang.length==0){
            break;
        }
        [mustring deleteCharactersInRange:rang];
    }
    
    NSData *htmlData =[html dataUsingEncoding:NSUTF8StringEncoding];
    NSString *nodeString = @"//p";
    TFHpple *xpathParser = [[TFHpple alloc]initWithHTMLData:htmlData];
    NSArray *elements =[xpathParser searchWithXPathQuery:nodeString];
    NSMutableArray *mArr = [NSMutableArray array];
    [elements enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = [obj children];
        TFHppleElement *href = arr.firstObject;
        NSString *tmpStr =[href content];
        if(tmpStr){
            int i;
            for(i =0;i<mArr.count;i++){
                if([tmpStr isEqualToString:mArr[i]]){
                    break;
                }
            }
            if(i==mArr.count){
                [mArr addObject:tmpStr];
            }
        }
    }];
    NSMutableString *result =[NSMutableString string];
    [mArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableString *mustring = obj.mutableCopy;
        if(mustring){
            while (1) {
                NSRange rang = [mustring rangeOfString:@"⏎"];
                if(rang.length ==0){
                    break;
                }
                [mustring deleteCharactersInRange:rang];
            }
            while (1) {
                if([mustring hasPrefix:@""]||[mustring hasPrefix:@" "]){
                    [mustring deleteCharactersInRange:NSMakeRange(0, 1)];
                }else if([mustring hasPrefix:@" "]){
                    [mustring deleteCharactersInRange:NSMakeRange(mustring.length -1, 1)];
                }else{
                    break;
                }
            }
            if (mustring.length>0) {
                if ([mustring hasPrefix:@"【"] && [mustring hasSuffix:@"】"]) {
                    
                    [result appendString:[NSString stringWithFormat:@"\n%@\n", mustring]];
                } else {
                    [result appendString:[NSString stringWithFormat:@"    %@\n", mustring]];
                }
            }
        }else{
        }
    }];
    self.viewLb = result;
}
- (XPSearchModel *)data {
    if(_data == nil) {
        _data = [[XPSearchModel alloc] init];
    }
    return _data;
}

@end
