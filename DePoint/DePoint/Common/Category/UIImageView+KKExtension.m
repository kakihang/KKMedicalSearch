//
//  UIImageView+KKExtension.m
//  DePoint
//
//  Created by kaki on 16/8/9.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "UIImageView+KKExtension.h"

@implementation UIImageView (KKExtension)

+ (instancetype)kk_imageWithMode:(UIViewContentMode)mode {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = mode;
    imageView.clipsToBounds = YES;
    return imageView;
}
+ (instancetype)kk_imageWithFrame:(CGRect)frame mode:(UIViewContentMode)mode {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = mode;
    imageView.clipsToBounds = YES;
    return imageView;
}
+ (instancetype)kk_imageWithImage:(UIImage *)image mode:(UIViewContentMode)mode {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = mode;
    imageView.clipsToBounds = YES;
    return imageView;
}
+ (instancetype)kk_imageWithImage:(UIImage *)image mode:(UIViewContentMode)mode radius:(CGFloat)radius {
    UIImageView *imageView = [UIImageView kk_imageWithImage:image mode:mode];
    imageView.layer.cornerRadius = radius;
    imageView.layer.masksToBounds = YES;
    return imageView;
}

+ (instancetype)kk_imageWithImageName:(NSString *)image mode:(UIViewContentMode)mode {
    return [self kk_imageWithImage:[UIImage imageNamed:image] mode:mode];
}

+ (instancetype)kk_imageWithImageName:(NSString *)image
                                frame:(CGRect)frame
                                 mode:(UIViewContentMode)mode {
    UIImageView *imageView = [UIImageView kk_imageWithImageName:image mode:mode];
    imageView.frame = frame;
    return imageView;
}


@end
