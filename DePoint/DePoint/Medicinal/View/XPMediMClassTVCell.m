//
//  XPMediMClassTVCell.m
//  DePoint
//
//  Created by apple on 16/8/13.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPMediMClassTVCell.h"

@implementation XPMediMClassTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [super setSelected:selected animated:animated];
}
- (UILabel *)label {
    if(_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = KKGlobalTitleTextFont;
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _label;
}

@end
