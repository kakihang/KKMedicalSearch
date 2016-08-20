//
//  LLFlowCell.m
//  DePoint
//
//  Created by LZB on 16/8/9.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "LLFlowCell.h"

@implementation LLFlowCell

- (UIImageView *)iocnIV {
    if(_iocnIV == nil) {
        _iocnIV = [[UIImageView alloc] init];
        _iocnIV.contentMode = UIViewContentModeScaleAspectFill;
        _iocnIV.clipsToBounds = YES;
        [self.contentView addSubview:_iocnIV];
        [_iocnIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(10);
           // make.size.equalTo(CGSizeMake(100, 70)).priorityHigh();
            make.width.equalTo(100);
            make.height.equalTo(70);
            
        }];
    }
    return _iocnIV;
}

- (UILabel *)nameLb {
    if(_nameLb == nil) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(30);
            make.left.equalTo(self.iocnIV.mas_right).equalTo(10);
            make.height.equalTo(30);
        }];
    }
    return _nameLb;
}

- (UILabel *)factory {
    if(_factory == nil) {
        _factory = [[UILabel alloc] init];
        _factory.font = [UIFont systemFontOfSize:14];
        _factory.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
        [self.contentView addSubview:_factory];
        [_factory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLb.mas_bottom).equalTo(15);
            make.left.equalTo(self.nameLb);
            make.right.equalTo(-10);
            make.height.equalTo(30);
        }];
    }
    return _factory;
}

- (UILabel *)supervise {
    if(_supervise == nil) {
        _supervise = [[UILabel alloc] init];
        _supervise.font = [UIFont systemFontOfSize:14];
        _supervise.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
        [self.contentView addSubview:_supervise];
        [_supervise mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.factory);
            make.top.equalTo(self.factory.mas_bottom).equalTo(10);
            make.right.equalTo(-10);
            make.height.equalTo(30);
        }];
    }
    return _supervise;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
