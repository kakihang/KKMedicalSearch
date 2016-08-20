//
//  XPDetailCell.m
//  DePoint
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPDetailCell.h"

@implementation XPDetailCell
- (UILabel *)nameLb {
    if(_nameLb == nil) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_nameLb];
        __weak typeof(self) weakSelf = self;
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.iconIV.mas_right);
            make.centerY.equalTo(weakSelf.iconIV);
            make.width.equalTo(weakSelf.contentView.mas_width);
        }];
    }
    return _nameLb;
}
- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
        _iconIV.clipsToBounds = YES;
        [self.contentView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.top.equalTo(10);
            make.size.equalTo(CGSizeMake(100, 80)).priorityHigh();
        }];
    }
    return _iconIV;
}

- (UITextView *)textLb {
    CGFloat height = self.contentView.frame.size.height -145 ;
    if(_textLb == nil) {
        _textLb = [[UITextView alloc] init];
        _textLb.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_textLb];
        __weak typeof(self) weakSelf = self;
        [_textLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf.contentView.mas_width);
            make.top.equalTo(weakSelf.iconIV.mas_bottom);
            make.left.equalTo(0);
            make.height.equalTo(height);
        }];
    }
    return _textLb;
}
- (void)awakeFromNib {
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}	
@end
