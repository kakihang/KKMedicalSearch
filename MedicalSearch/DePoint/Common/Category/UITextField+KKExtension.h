//
//  UITextField+KKExtension.h
//  DePoint
//
//  Created by kaki on 16/8/11.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (KKExtension)
+ (instancetype)kk_createWithPlaceholder:(NSString *)placeholder;
+ (instancetype)kk_createPwdWithPlaceholder:(NSString *)placeholder;
@end
