//
//  KKSetLoginTVCell.m
//  DePoint
//
//  Created by kaki on 16/8/22.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKSetLoginTVCell.h"

@implementation KKSetLoginTVCell

+ (instancetype)cellWithIdentifier:(NSString *)identifier {
    KKSetLoginTVCell *cell = [[KKSetLoginTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell  iconView];
    [cell  loginTitle];
    return cell;
}

- (UIImageView *)iconView {
    if(_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        __weak typeof(self) weakSelf = self;
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(KKScreenWidthPrecent(0.058));
            make.height.mas_equalTo(weakSelf.contentView.mas_height).multipliedBy(0.6);
            make.width.mas_equalTo(_iconView.mas_height);
        }];
    }
    return _iconView;
}

- (UILabel *)loginTitle {
    if(_loginTitle == nil) {
        _loginTitle = [[UILabel alloc] init];
        _loginTitle.font = KKGlobalDetailTextFont;
        _loginTitle.textColor = KKGlobalTextGreenColor;
        [self.contentView addSubview:_loginTitle];
        [_loginTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(_iconView.mas_right).mas_equalTo(KKScreenWidthPrecent(0.04));
        }];
    }
    return _loginTitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
