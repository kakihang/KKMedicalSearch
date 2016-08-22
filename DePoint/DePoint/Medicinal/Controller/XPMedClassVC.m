//
//  XPMedClassVC.m
//  DePoint
//
//  Created by apple on 16/8/13.
//  Copyright © 2016年 liudhkk. All rights reserved.
//


#define KKBottomViewCoverColor KKCOLOR(0, 104, 89, 1)

#import "XPMedClassVC.h"
#import "XPListViewCell.h"
#import "XPSearchController.h"
#import "XPListModel.h"
#import "XPDetailController.h"
@interface XPMedClassVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) NSInteger cIndex;
@property (nonatomic) NSInteger nIndex;
@property (nonatomic) NSArray *plistData;
@property (nonatomic) UITableView *leftView;
@property (nonatomic) UITableView *rightView;
@property (nonatomic) UIView *bgView;
@property (nonatomic) UIButton *leftBt;
@property (nonatomic) UIButton *rightBt;
@property (nonatomic) UIView *bottomView;
@property (nonatomic) UITableView *listView;
@property (nonatomic) NSInteger page;
@property (nonatomic) NSMutableArray<XPListDataModel *> *data;
@end

@implementation XPMedClassVC{
    BOOL _menuHiddex;
    BOOL _menuAnimationFlag;
    CGFloat _height;
    CGFloat _maxHeight;
    CGFloat _trueHeight;
}

static NSString *leftCell = @"leftCell";
static NSString *rightCell = @"rightCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    __weak typeof(self) weakSelf = self;
    [XPFactory addSearchItemForVC:self clickedHandler:^{
        XPSearchController *vc =[[XPSearchController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    _menuAnimationFlag = NO;
    _menuHiddex = YES;
    _height = 40;
    _maxHeight = KKScreenHeightPrecent(0.6);
    _trueHeight = _height * self.plistData.count;
    if(_trueHeight > _maxHeight){
        _trueHeight = _maxHeight;
    }
    self.view.backgroundColor = KKGLOBAL;
    [self leftBt];
    [self rightBt];
    [self.listView registerClass:[XPListViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.leftView registerClass:[UITableViewCell class] forCellReuseIdentifier:leftCell];
    [self.rightView registerClass:[UITableViewCell class] forCellReuseIdentifier:rightCell];
    [self.leftView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self setMainButtonTitle];
    [self XPnetwork:[NSIndexPath indexPathForRow:_nIndex inSection:0]];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

-(instancetype)initWithClassIndex:(NSInteger)cindex nindex:(NSInteger)nindex data:(NSArray *)plistData{
    if(self = [super init]){
        self.cIndex = cindex;
        self.nIndex = nindex;
        self.plistData = plistData;
    }
    return self;
}
-(void)setMainButtonTitle{
    [self.leftBt setTitle:self.plistData[_cIndex][@"name"] forState:UIControlStateNormal];
    [self.rightBt setTitle:self.plistData[_cIndex][@"idList"][_nIndex][@"name"] forState:UIControlStateNormal];
    
}
-(void)clickMainButton{
    if (_menuAnimationFlag) {
        return;
    }
    _menuAnimationFlag = YES;
    [self.bgView.superview layoutIfNeeded];
    self.leftBt.enabled = NO;
    self.rightBt.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        if (weakSelf.bgView.height == 0) {
            [weakSelf.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(weakSelf.leftBt.mas_bottom);
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(_trueHeight);
            }];
            weakSelf.bottomView.alpha = 0.3;
            weakSelf.bottomView.hidden = NO;
        } else {
            [weakSelf.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.top.mas_equalTo(weakSelf.leftBt.mas_bottom);
                make.height.mas_equalTo(0);
            }];
            weakSelf.bottomView.alpha = 0;
        }
        [weakSelf.bgView.superview layoutIfNeeded];//强制绘制
    } completion:^(BOOL finished) {
        weakSelf.leftBt.enabled = YES;
        weakSelf.rightBt.enabled = YES;
        _menuAnimationFlag = NO;
        weakSelf.bottomView.hidden = weakSelf.bgView.height == 0;
    }];
}

#pragma make -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView ==self.leftView){
        return _plistData.count;
    }else if(tableView ==self.rightView){
        return ((NSArray *)_plistData[_cIndex][@"idList"]).count;
    }else{
        return self.data.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView ==self.leftView){
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:leftCell forIndexPath:indexPath];
        cell.textLabel.text = _plistData[indexPath.row][@"name"];
        cell.textLabel.font = KKGlobalTitleTextFont;
        return cell;
    }else if(tableView ==self.rightView){
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:rightCell forIndexPath:indexPath];
        cell.textLabel.text = _plistData[_cIndex][@"idList"][indexPath.row][@"name"];
        cell.textLabel.font = KKGlobalTitleTextFont;
        cell.backgroundColor = KKCOLOR(217, 217, 217, 1);
        return cell;
    }else{
        XPListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.nameLb.text = self.data[indexPath.row].name;
        cell.titleLb.text = self.data[indexPath.row].desc;
        [cell.iconIV setImageWithURL:[NSString stringWithFormat:@"http://tnfs.tngou.net/image%@",self.data[indexPath.row].img].yx_URL placeholder:[UIImage imageNamed:@"背景"]];
        return  cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView ==self.leftView){
        _cIndex = indexPath.row;
        [self.rightView reloadData];
    }else if(tableView == self.rightView){
        _nIndex = indexPath.row;
        [self clickMainButton];
        [self setMainButtonTitle];
        [self XPnetwork:indexPath];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        XPDetailController *vc =[[XPDetailController alloc]initWithDetai:self.data[indexPath.row].ID];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - LazyLoad  懒加载
- (UIButton *)leftBt {
    if(_leftBt == nil) {
        _leftBt = [[UIButton alloc] init];
        _leftBt.titleLabel.font = KKGlobalTitleTextFont;
        [_leftBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftBt addTarget:self action:@selector(clickMainButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_leftBt];
        [_leftBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(64);
            make.height.mas_equalTo(_height);
        }];
    }
    return _leftBt;
}

- (UIButton *)rightBt {
    if(_rightBt == nil) {
        _rightBt = [[UIButton alloc] init];
        _rightBt.titleLabel.font = KKGlobalTitleTextFont;
        [_rightBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightBt addTarget:self action:@selector(clickMainButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_rightBt];
        __weak typeof(self) weakSelf = self;
        [_rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(weakSelf.leftBt);
            make.height.mas_equalTo(weakSelf.leftBt);
            make.left.mas_equalTo(weakSelf.leftBt.mas_right);
            make.width.mas_equalTo(weakSelf.leftBt.mas_width);
        }];
    }
    return _rightBt;
}
- (UITableView *)leftView {
    if(_leftView == nil) {
        _leftView = [[UITableView alloc] init];
        _leftView.dataSource = self;
        _leftView.delegate = self;
        _leftView.rowHeight = _height;
        [self.bgView addSubview:_leftView];
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(0);
        }];
    }
    return _leftView;
}
- (UITableView *)rightView {
    if(_rightView == nil) {
        _rightView = [[UITableView alloc] init];
        _rightView.dataSource = self;
        _rightView.delegate = self;
        _rightView.rowHeight = _height;
        _rightView.backgroundColor = KKCOLOR(217, 217, 217, 1);
        [self.bgView addSubview:_rightView];
        __weak typeof(self) weakSelf = self;
        [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(0);
            make.left.mas_equalTo(weakSelf.leftView.mas_right);
            make.width.mas_equalTo(weakSelf.leftView);
            make.height.mas_equalTo(weakSelf.leftView);
        }];
    }
    return _rightView;
}
- (UIView *)bgView {
    if(_bgView == nil) {
        
        __weak typeof(self) weakSelf = self;
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = KKBottomViewCoverColor;
        bottomView.alpha = 0;
        [self.view addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(weakSelf.leftBt.mas_bottom);
        }];
        [bottomView bk_whenTapped:^{
            [weakSelf clickMainButton];
        }];
        UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            [weakSelf clickMainButton];
        }];
        [bottomView addGestureRecognizer:gr];
        gr.direction = UISwipeGestureRecognizerDirectionUp;
        self.bottomView = bottomView;
        
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.mas_equalTo(weakSelf.leftBt.mas_bottom);
            make.left.right.height.equalTo(0);
        }];
        
    }
    return _bgView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (UITableView *)listView {
    if(_listView == nil) {
        _listView = [[UITableView alloc] init];
        _listView.dataSource =self;
        _listView.delegate = self;
        [self.view addSubview:_listView];
        __weak typeof(self) weakSelf = self;
        [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.leftBt.mas_bottom);
            make.left.right.bottom.equalTo(0);
        }];
    }
    return _listView;
}
- (NSMutableArray<XPListDataModel *> *)data {
    if(_data == nil) {
        _data = [[NSMutableArray<XPListDataModel *> alloc] init];
    }
    return _data;
}
-(void)XPnetwork:(NSIndexPath *)indexPath{
    NSInteger path = 1;
    __weak typeof(self) weakSelf = self;
    [self.listView addHeaderRefresh:^{
        [XPNetManager getList:[weakSelf.plistData[weakSelf.cIndex][@"idList"][indexPath.row][@"id"]integerValue] more:path completionHandler:^(XPListModel *model, NSError *error) {
            [weakSelf.data removeAllObjects];
            [weakSelf.data addObjectsFromArray:model.tngou];
            [weakSelf.listView endHeaderRefresh];
            [weakSelf.listView reloadData];
        }];
    }];
    [self.listView beginHeaderRefresh];
    self.page = path + 1;
    [self.listView addFooterRefresh:^{
        [XPNetManager getList:[weakSelf.plistData[weakSelf.cIndex][@"idList"][indexPath.row][@"id"]integerValue] more:weakSelf.page completionHandler:^(XPListModel *model, NSError *error) {
            weakSelf.page +=1;
            [weakSelf.data addObjectsFromArray:model.tngou];
            [weakSelf.listView endFooterRefresh];
            [weakSelf.listView reloadData];
        }];
    }];
    self.listView.rowHeight = 130;
    self.listView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
}


@end
