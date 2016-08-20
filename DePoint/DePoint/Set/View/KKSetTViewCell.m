//
//  KKSetTViewCell.m
//  DePoint
//
//  Created by kaki on 16/8/4.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKSetTViewCell.h"

@implementation KKSetTViewCell

+ (instancetype)cellWithIdentifier:(NSString *)identifier {
    KKSetTViewCell *cell = [[KKSetTViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark -

- (UIImageView *)iconView {
    if(_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.clipsToBounds = YES;
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(KKBWIDTHPRECENT(20));
            make.height.mas_equalTo(self.contentView.mas_height).multipliedBy(0.5);
            make.width.mas_equalTo(_iconView.mas_height);
        }];
    }
    return _iconView;
}

- (UILabel *)titleLa {
    if(_titleLa == nil) {
        _titleLa = [[UILabel alloc] init];
        _titleLa.font = [UIFont systemFontOfSize:15];
        _titleLa.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLa];
        [_titleLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.iconView);
            make.left.mas_equalTo(self.iconView.mas_right).mas_equalTo(KKBWIDTHPRECENT(10));
        }];
    }
    return _titleLa;
}

- (UILabel *)assistLa {
    if(_assistLa == nil) {
        _assistLa = [[UILabel alloc] init];
        _assistLa.font = [UIFont systemFontOfSize:14];
        _assistLa.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        [self.contentView addSubview:_assistLa];
        [_assistLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLa);
            make.right.mas_equalTo(self.contentView.mas_right).mas_equalTo(-KKBWIDTHPRECENT(20));
            make.left.mas_equalTo(self.titleLa.mas_right).mas_equalTo(10).priorityLow();
        }];
    }
    return _assistLa;
}

@end
