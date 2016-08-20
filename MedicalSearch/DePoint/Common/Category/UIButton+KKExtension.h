//
//  UIButton+KKExtension.h
//  DePoint
//
//  Created by kaki on 16/8/10.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (KKExtension)

+ (instancetype)kk_buttonWithType:(UIButtonType)buttonType title:(NSString *)title;
+ (instancetype)kk_buttonWithTitle:(NSString *)title;

@end
