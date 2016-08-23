//
//  KKSearchInfoView.m
//  DePoint
//
//  Created by LZB on 16/8/21.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKSearchInfoView.h"

@implementation KKSearchInfoView

- (instancetype)init {
    if (self = [super init]) {
        [self inquiry];
        [self time];
        [self go];
    }
    return self;
}

- (UILabel *)inquiry {
    if(_inquiry == nil) {
        _inquiry = [[UILabel alloc] init];
        _inquiry.font = [UIFont systemFontOfSize:16];
        [self addSubview:_inquiry];
        [_inquiry mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(10);
            make.right.equalTo(-10);
            make.left.equalTo(20);
            make.height.equalTo(25);
        }];
        
    }
    return _inquiry;
}

- (UILabel *)time {
    if(_time == nil) {
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:13];
        [self addSubview:_time];
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.inquiry.mas_bottom).equalTo(5);
            make.left.equalTo(self.inquiry);
            make.right.equalTo(-10);
            make.height.equalTo(20);
        }];
    }
    return _time;
}



- (NSMutableArray<UIImageView *> *)go {
    
    if (!_go) {
        _go = [NSMutableArray new];
        UIImageView *last = nil;
        for (int i = 0; i < 7; i++) {
            UIImageView *Lb = [UIImageView new];
            [_go addObject:Lb];
            [self addSubview:Lb];
            [Lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(0);
                if (i == 0) {
                    make.top.equalTo(self.time.mas_bottom).equalTo(10);
                    make.size.equalTo(CGSizeMake(50, 50));
                }else if(i % 2 == 0){
                    make.top.equalTo(last.mas_bottom).equalTo(5);
                    make.size.equalTo(CGSizeMake(50, 50));
                }else{
                    make.top.equalTo(last.mas_bottom).equalTo(5);
                    make.size.equalTo(CGSizeMake(30, 30));
                }
            }];
            last = Lb;
        }
    }
    return _go;
}

@end
