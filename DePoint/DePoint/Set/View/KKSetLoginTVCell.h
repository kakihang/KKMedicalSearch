//
//  KKSetLoginTVCell.h
//  DePoint
//
//  Created by kaki on 16/8/22.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKSetLoginTVCell : UITableViewCell

+ (instancetype)cellWithIdentifier:(NSString *)identifier;

@property (nonatomic, strong) UIImageView *iconView; // 头像
@property (nonatomic, strong) UILabel *loginTitle; // 登录

@end
