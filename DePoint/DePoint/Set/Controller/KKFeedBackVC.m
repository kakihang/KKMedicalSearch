//
//  KKFeedBackVC.m
//  DePoint
//
//  Created by kaki on 16/8/4.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKFeedBackVC.h"
#import "KKPlaceholderTextView.h"
#import <BmobSDK/Bmob.h>

@interface KKFeedBackVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView; //
@property (nonatomic, strong) KKPlaceholderTextView *msgText; //
@property (nonatomic, strong) UITextField *linkText; //
@property (nonatomic, strong) UILabel *desLa; //
@end

@implementation KKFeedBackVC {
    BOOL _errFlag;
}

static NSString *cellID_ = @"KKFeedBackVCCellId";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"意见反馈" tintColor:KKGLOTINTCOLOR backgroundColor:KKGLOBARCOLOR];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID_];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    
    // 发送按钮
    UIButton *sendBt = [UIButton buttonWithType:UIButtonTypeSystem];
    sendBt.frame = CGRectMake(0, 0, 50, 40);
    [sendBt setTitle:@"发送" forState:UIControlStateNormal];
    [sendBt addTarget:self action:@selector(sendMsg:) forControlEvents:UIControlEventTouchUpInside];
    [self setNavBarRightBtn:sendBt];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

UIWindow *showWin_;
- (void)sendMsg:(UIButton *)sender { // 发送反馈意见
    sender.enabled = NO;
    
    
    // 添加提示框
    UILabel *label = [[UILabel alloc] init];
    
    if (!showWin_) {
        CGFloat width = 150;
        CGFloat height = 50;
        CGFloat x = KKSCREENBOUNDSIZE.width*0.5 - width/2.0;
        CGFloat y = KKSCREENBOUNDSIZE.height*0.5 - height/2.0;
        CGRect frame = CGRectMake(x, y, width, height);
        
        showWin_ = [[UIWindow alloc] initWithFrame:frame];
        showWin_.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.8];
        
        [showWin_ addSubview:label];
        [label setTextColor:[UIColor colorWithWhite:0.9 alpha:0.9]];
        label.frame = CGRectMake(0, 0, width, height);
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    showWin_.hidden = NO;
    showWin_.alpha = 1;
    
    
    if ([self.msgText hasText]) {
        
        //往FeedBack表添加一条数据
        BmobObject *feedBack = [BmobObject objectWithClassName:@"FeedBack"];
        [feedBack setObject:self.linkText.text forKey:@"link"];
        [feedBack setObject:self.msgText.text forKey:@"message"];
        [feedBack saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            //进行操作
            if (!error) {
                _errFlag = NO;
                NSLog(@"保存成功： %@ : %@ ", self.linkText.text, self.msgText.text);
                [label setText:@"发送成功~"];
            } else {
                _errFlag = YES;
                [label setText:@"发送失败!!!"];
            }
            [self showSendMsg:sender];
        }];
    } else {
        _errFlag = YES;
        [label setText:@"请输入内容!!!"];
        [self showSendMsg:sender];
    }
}

- (void)showSendMsg:(UIButton *)sender {
    [UIView animateWithDuration:2.0 animations:^{
        showWin_.alpha = 0;
    } completion:^(BOOL finished) {
        if (!_errFlag) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        showWin_.hidden = YES;
        showWin_ = nil;
        sender.enabled = YES;
    }];
}



- (void)dealloc {
    NSLog(@"%s dealloc", __func__);
}


#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat margin = 15;
#define KKMakeCons             \
make.top.bottom.mas_equalTo(0); \
make.left.mas_equalTo(margin); \
make.right.mas_equalTo(-margin);
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID_];
    if (indexPath.row == 0) {
        [cell.contentView addSubview:self.msgText];
        [self.msgText mas_makeConstraints:^(MASConstraintMaker *make) {
            KKMakeCons
        }];
    } else if (indexPath.row == 1) {
        [cell.contentView addSubview:self.linkText];
        [self.linkText mas_makeConstraints:^(MASConstraintMaker *make) {
            KKMakeCons
        }];
    } else {
        [cell.contentView addSubview:self.desLa];
        [self.desLa mas_makeConstraints:^(MASConstraintMaker *make) {
            KKMakeCons
        }];
    }
    
    [cell kk_addBottomLine];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 150;
    } else if (indexPath.row == 1) {
        return 40;
    } else {
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _tableView;
}

- (KKPlaceholderTextView *)msgText {
    if(_msgText == nil) {
        _msgText = [[KKPlaceholderTextView alloc] init];
        [_msgText setPlaceholderColor:KKCOLOR(202, 202, 208, 1)];
        [_msgText setPlaceholder:@"请简单描述你的建议或所遇到的问题，还可以留下你的QQ、邮箱或电话，工作人员会尽快处理~"];
    }
    return _msgText;
}

- (UITextField *)linkText {
    if(_linkText == nil) {
        _linkText = [[UITextField alloc] init];
        _linkText.font = [UIFont systemFontOfSize:13];
        [_linkText setPlaceholder:@"你的QQ、邮箱或电话"];
    }
    return _linkText;
}

- (UILabel *)desLa {
    if(_desLa == nil) {
        _desLa = [[UILabel alloc] init];
        _desLa.font = [UIFont systemFontOfSize:13];
        _desLa.text = @"以上内容仅对本APP内部工作人员可见你，可帮助更好的解决问题，优化体验。";
        _desLa.numberOfLines = 2;
    }
    return _desLa;
}

@end
