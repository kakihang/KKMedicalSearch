//
//  KKSearchMsgTVCell.m
//  DePoint
//
//  Created by kaki on 16/8/23.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKSearchMsgTVCell.h"

@implementation KKSearchMsgTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (KKSearchInfoView *)infoView {
    if(_infoView == nil) {
        _infoView = [[KKSearchInfoView alloc] init];
        [self.contentView addSubview:_infoView];
        [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _infoView;
}

- (KKSearchFlowDirectionView *)flowDirection {
    if(_flowDirection == nil) {
        _flowDirection = [[KKSearchFlowDirectionView alloc] init];
        [self.contentView addSubview:_flowDirection];
        [_flowDirection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _flowDirection;
}


@end
