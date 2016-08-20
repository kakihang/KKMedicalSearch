//
//  UIImageView+KKExtension.h
//  DePoint
//
//  Created by kaki on 16/8/9.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (KKExtension)
+ (instancetype)kk_imageWithMode:(UIViewContentMode)mode;
+ (instancetype)kk_imageWithFrame:(CGRect)frame mode:(UIViewContentMode)mode;
+ (instancetype)kk_imageWithImage:(UIImage *)image mode:(UIViewContentMode)mode;
+ (instancetype)kk_imageWithImageName:(NSString *)image mode:(UIViewContentMode)mode;
+ (instancetype)kk_imageWithImageName:(NSString *)image
                                frame:(CGRect)frame
                                 mode:(UIViewContentMode)mode;
+ (instancetype)kk_imageWithImage:(UIImage *)image
                             mode:(UIViewContentMode)mode
                           radius:(CGFloat)radius;
@end
