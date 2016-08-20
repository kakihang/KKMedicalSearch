//
//  XPSearchCell.m
//  DePoint
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPSearchCell.h"

@implementation XPSearchCell
- (UITextView *)textLb {
    if(_textLb == nil) {
        _textLb = [[UITextView alloc] init];
        _textLb.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_textLb];
        __weak typeof(self) weakSelf = self;
        [_textLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf.contentView.mas_width);
            make.top.equalTo(0);
            make.left.equalTo(0);
            make.height.equalTo(weakSelf.contentView.mas_height).equalTo(-30);
        }];
    }
    return _textLb;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
