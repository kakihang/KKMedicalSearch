//
//  KKSetTViewCell.h
//  DePoint
//
//  Created by kaki on 16/8/4.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKSetTViewCell : UITableViewCell


@property (nonatomic, strong) UIImageView *iconView; // imageView
@property (nonatomic, strong) UILabel *titleLa; // title
@property (nonatomic, strong) UILabel *assistLa; // 辅助title

+ (instancetype)cellWithIdentifier:(NSString *)identifier;


@end
