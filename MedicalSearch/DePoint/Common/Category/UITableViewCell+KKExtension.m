//
//  UITableViewCell+KKExtension.m
//  DePoint
//
//  Created by kaki on 16/8/16.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "UITableViewCell+KKExtension.h"

@implementation UITableViewCell (KKExtension)

- (void)kk_addBottomLine{
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = KKCOLOR(225, 225, 225, 1.0);
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(0);
        make.left.mas_equalTo(KKScreenWidthPrecent(0.0493));
        make.height.mas_equalTo(1);
    }];
}

@end
