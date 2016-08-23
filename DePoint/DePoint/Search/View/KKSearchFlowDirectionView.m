//
//  KKSearchFlowDirectionView.m
//  DePoint
//
//  Created by LZB on 16/8/18.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKSearchFlowDirectionView.h"

@interface KKSearchFlowDirectionView ()

@end

@implementation KKSearchFlowDirectionView

- (instancetype)init {
    if (self = [super init]) {
        [self detailsLb];
    }
    return self;
}

- (NSMutableArray<UILabel *> *)detailsLb {
    
    if (!_detailsLb) {
        _detailsLb = [NSMutableArray new];
        UIView *last = nil;
        for (int i = 0; i < 10; i++) {
            UILabel *Lb = [UILabel new];
            [_detailsLb addObject:Lb];
            Lb.font = [UIFont systemFontOfSize:15];
            [self addSubview:Lb];
            [Lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(-10);
                make.left.equalTo(20);
                make.height.equalTo(25);
                if (i == 0) {
                    make.top.equalTo(10);
                    
                }else{
                    make.top.equalTo(last.mas_bottom).equalTo(15);
                    
                }
            }];
            last = Lb;
        }
    }
    return _detailsLb;
}

@end
