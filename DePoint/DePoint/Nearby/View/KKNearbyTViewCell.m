//
//  KKNearbyTViewCell.m
//  DePoint
//
//  Created by kaki on 16/8/2.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKNearbyTViewCell.h"

@implementation KKNearbyTViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (UILabel *)nameLb {
    if(_nameLb == nil) {
        _nameLb = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLb];
        _nameLb.font = [UIFont systemFontOfSize:18];
        _nameLb.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
            make.width.mas_lessThanOrEqualTo(300);
        }];
    }
    return _nameLb;
}

- (UILabel *)addressLb {
    if(_addressLb == nil) {
        __weak typeof(self) weakSelf = self;
        _addressLb = [[UILabel alloc] init];
        [self.contentView addSubview:_addressLb];
        _addressLb.font = [UIFont systemFontOfSize:13];
        _addressLb.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        [_addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameLb.mas_bottom).mas_equalTo(0);
            make.left.mas_equalTo(weakSelf.nameLb.mas_left);
            make.width.mas_lessThanOrEqualTo(300);
            make.bottom.mas_equalTo(-10);
        }];
    }
    return _addressLb;
}


- (UILabel *)distanceLb {
    if(_distanceLb == nil) {
        _distanceLb = [[UILabel alloc] init];
        [self.contentView addSubview:_distanceLb];
        _distanceLb.font = [UIFont systemFontOfSize:16];
        _distanceLb.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
        [_distanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-15);
        }];
    }
    return _distanceLb;
}

@end
