//
//  KKNearbyTViewCell.m
//  DePoint
//
//  Created by kaki on 16/8/2.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKNearbyTViewCell.h"

@implementation KKNearbyTViewCell {
    CGFloat _leftMargin;
    CGFloat _rightMargin;
    CGFloat _topMargin;
    CGFloat _bottomMargin;
    CGFloat _margin;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (UILabel *)nameLb {
    if(_nameLb == nil) {
        _leftMargin = KKScreenWidthPrecent(0.04);
        _rightMargin = KKScreenWidthPrecent(0.04);
        _topMargin = KKScreenHeightPrecent(0.015);
        _margin = KKScreenHeightPrecent(0.015);
        _bottomMargin = _topMargin;
        
        _nameLb = [[UILabel alloc] init];
        [self.contentView addSubview:_nameLb];
        _nameLb.font = [UIFont systemFontOfSize:18];
        _nameLb.textColor = KKGlobalTextGreenColor;
        _nameLb.highlightedTextColor = KKGlobalTextWhiteColor;
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_topMargin);
            make.left.mas_equalTo(_leftMargin);
        }];
        
        // 右边的图标
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sh"]];
        [self.contentView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_nameLb);
            make.left.mas_equalTo(_nameLb.mas_right).mas_equalTo(_leftMargin/3);
            make.size.mas_equalTo(CGSizeMake(12, 15)).priorityHigh();
        }];
        
        // 分割线
        UIView *halvingLine = [[UIView alloc] init];
        halvingLine.backgroundColor = KKGlobalHalvingLineColor;
        [self.contentView addSubview:halvingLine];
        [halvingLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.height.mas_equalTo(1);
            make.bottom.mas_equalTo(0);
        }];
        
        // 设置cell的背景颜色
        self.backgroundColor = KKGlobalControllerBackgroundColor;
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView = backgroundView;
        self.selectedBackgroundView.backgroundColor = KKGlobalTextGreenColor;
    }
    return _nameLb;
}

- (UILabel *)addressLb {
    if(_addressLb == nil) {
        [self nameLb];
        __weak typeof(self) weakSelf = self;
        _addressLb = [[UILabel alloc] init];
        [self.contentView addSubview:_addressLb];
        _addressLb.font = [UIFont systemFontOfSize:13];
        _addressLb.textColor = KKGlobalTextGreenColor;
        _addressLb.highlightedTextColor = KKGlobalTextWhiteColor;
        _addressLb.numberOfLines = 0;
        [_addressLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameLb.mas_bottom).mas_equalTo(_topMargin/2);
            make.left.mas_equalTo(weakSelf.nameLb.mas_left);
            make.right.mas_equalTo(-_rightMargin);
            make.bottom.mas_equalTo(-_bottomMargin);
        }];
    }
    return _addressLb;
}


- (UILabel *)distanceLb {
    if(_distanceLb == nil) {
        [self nameLb];
        _distanceLb = [[UILabel alloc] init];
        [self.contentView addSubview:_distanceLb];
        _distanceLb.font = [UIFont systemFontOfSize:13];
        _distanceLb.textColor = KKGlobalTextGreenColor;
        _distanceLb.highlightedTextColor = KKGlobalTextWhiteColor;
        __weak typeof(self) weakSelf = self;
        [_distanceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.nameLb);
            make.right.mas_equalTo(-_rightMargin);
        }];
    }
    return _distanceLb;
}

@end
