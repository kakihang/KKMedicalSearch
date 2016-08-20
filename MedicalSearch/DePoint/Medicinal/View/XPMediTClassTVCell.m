//
//  XPMediTClassTVCell.m
//  DePoint
//
//  Created by apple on 16/8/13.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPMediTClassTVCell.h"

@implementation XPMediTClassTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (UIButton *)firstBt {
    if(_firstBt == nil) {
        _firstBt = [[UIButton alloc] init];
        _firstBt.titleLabel.font = KKGlobalTitleTextFont;
        __weak typeof(self) weakSelf = self;
        [self.contentView addSubview:_firstBt];
        [_firstBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _firstBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _firstBt.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_firstBt bk_addEventHandler:^(id sender) {
            [weakSelf.XPCellClickDelegate cellClickIndex:0];
        } forControlEvents:UIControlEventTouchUpInside];
        [_firstBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(weakSelf.contentView.bounds.size.width / 2, 50)).priorityHigh();
            make.bottom.mas_equalTo(weakSelf.thirdBt.mas_top).equalTo(0);
        }];
        UIImageView *xp =[UIImageView new];
        xp.backgroundColor = KKCOLOR(0, 104, 89, 0.8);
        xp.layer.cornerRadius = 15;
        xp.clipsToBounds = YES;
        [_firstBt addSubview:xp];
        [xp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30).priorityHigh();
            make.right.equalTo(-20);
            make.top.equalTo(_firstBt.mas_top).equalTo(10);
            make.bottom.equalTo(_firstBt.mas_bottom).equalTo(-10);
        }];
        
    }
    return _firstBt;
}
- (UIButton *)secondBt {
    if(_secondBt == nil) {
        _secondBt = [[UIButton alloc] init];
        _secondBt.titleLabel.font = KKGlobalTitleTextFont;
        [_secondBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_secondBt];
        _secondBt.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _secondBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        __weak typeof(self) weakSelf = self;
        [_secondBt bk_addEventHandler:^(id sender) {
            [weakSelf.XPCellClickDelegate cellClickIndex:1];
        } forControlEvents:UIControlEventTouchUpInside];
        [_secondBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_firstBt.mas_right).equalTo(1);
            make.top.equalTo(10);
            make.size.equalTo(_firstBt).priorityHigh();
            make.bottom.equalTo(weakSelf.firstBt.mas_bottom);
            make.right.equalTo(-10);
        }];
        UIImageView *xp =[UIImageView new];
        xp.backgroundColor = KKCOLOR(0, 104, 89, 0.8);
        xp.layer.cornerRadius = 15;
        xp.clipsToBounds = YES;
        [_secondBt addSubview:xp];
        [xp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30).priorityHigh();
            make.right.equalTo(-20);
            make.top.equalTo(_secondBt.mas_top).equalTo(10);
            make.bottom.equalTo(_secondBt.mas_bottom).equalTo(-10);
        }];
    }
    return _secondBt;
}
- (UIButton *)thirdBt {
    if(_thirdBt == nil) {
        _thirdBt = [[UIButton alloc] init];
        _thirdBt.titleLabel.font = KKGlobalTitleTextFont;
        [_thirdBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _thirdBt.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _thirdBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_thirdBt];
        __weak typeof(self) weakSelf = self;
        [_thirdBt bk_addEventHandler:^(id sender) {
            [weakSelf.XPCellClickDelegate cellClickIndex:2];
        } forControlEvents:UIControlEventTouchUpInside];
        [_thirdBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.firstBt.mas_left);
            make.size.equalTo(_firstBt).priorityHigh();
            make.bottom.equalTo(-10);
        }];
        UIImageView *xp =[UIImageView new];
        xp.backgroundColor = KKCOLOR(0, 104, 89, 0.8);
        xp.layer.cornerRadius = 15;
        xp.clipsToBounds = YES;
        [_thirdBt addSubview:xp];
        [xp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30).priorityHigh();
            make.right.equalTo(-20);
            make.top.equalTo(_thirdBt.mas_top).equalTo(10);
            make.bottom.equalTo(_thirdBt.mas_bottom).equalTo(-10);
        }];
    }
    return _thirdBt;
}

@end
