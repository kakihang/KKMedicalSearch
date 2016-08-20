//
//  LLIntroCell.h
//  DePoint
//
//  Created by LZB on 16/8/16.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLIntroCell : UITableViewCell

@property (nonatomic) UIImageView *fixed;//固定图
@property (nonatomic) UILabel *nameLb;//药品名字
@property (nonatomic) UILabel *millLb;//制造工厂
@property (nonatomic) UILabel *codeLb;//13位条形码
@property (nonatomic) UILabel *informationLb;//消息标题
@property (nonatomic) UIButton *details;//详情按钮

@end
