//
//  LLIntroBelowCell.m
//  DePoint
//
//  Created by LZB on 16/8/10.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "LLIntroBelowCell.h"

@implementation LLIntroBelowCell

- (UIView *)division {
    if(_division == nil) {
        _division = [[UIView alloc] init];
        [self.contentView addSubview:_division];
        [_division mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.height.equalTo(2);
        }];
    }
    return _division;
}

- (UILabel *)norms {
    if(_norms == nil) {
        _norms = [[UILabel alloc] init];
        [self.contentView addSubview:_norms];
        [_norms mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.top.equalTo(self.division.mas_bottom).equalTo(20);
            make.height.equalTo(25);
            make.right.equalTo(-20);
        }];
    }
    return _norms;
}

- (UILabel *)ratify {
    if(_ratify == nil) {
        _ratify = [[UILabel alloc] init];
        [self.contentView addSubview:_ratify];
        [_ratify mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.norms);
            make.top.equalTo(self.norms.mas_bottom).equalTo(20);
            make.height.equalTo(25);
            make.right.equalTo(-20);
        }];
    }
    return _ratify;
}

- (UILabel *)pack {
    if(_pack == nil) {
        _pack = [[UILabel alloc] init];
        [self.contentView addSubview:_pack];
        [_pack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.ratify);
            make.top.equalTo(self.ratify.mas_bottom).equalTo(20);
            make.height.equalTo(25);
            make.right.equalTo(-20);
        }];
    }
    return _pack;
}

- (UILabel *)ratif {
    if(_ratif == nil) {
        _ratif = [[UILabel alloc] init];
        [self.contentView addSubview:_ratif];
        [_ratif mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pack);
            make.top.equalTo(self.pack.mas_bottom).equalTo(20);
            make.height.equalTo(25);
            make.right.equalTo(-20);
        }];
    }
    return _ratif;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
