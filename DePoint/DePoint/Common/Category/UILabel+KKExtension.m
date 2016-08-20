//
//  UILabel+KKExtension.m
//  DePoint
//
//  Created by kaki on 16/8/11.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "UILabel+KKExtension.h"

@implementation UILabel (KKExtension)
+ (instancetype)kk_labelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    return label;
}


@end
