//
//  UIView+KKVisualEff.m
//  DePoint
//
//  Created by kaki on 16/8/10.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "UIView+KKVisualEff.h"

@implementation UIView (KKVisualEff)
- (id)kk_viewWithVisualEffName:(NSString *)image {
    return [self kk_viewWithVisualEffName:image alpha:1.0];
}

- (id)kk_viewWithVisualEffName:(NSString *)image alpha:(CGFloat)alpha {
    UIImageView *imageView = [UIImageView kk_imageWithImageName:image mode:UIViewContentModeScaleAspectFill];
    [self addSubview:imageView];
    imageView.frame = self.bounds;
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [imageView addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    effectView.alpha = alpha;
    
    return imageView;
}

@end
