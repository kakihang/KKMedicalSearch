//
//  KKLoginRegisButton.m
//  DePoint
//
//  Created by kaki on 16/8/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKLoginRegisButton.h"

@implementation KKLoginRegisButton

+ (instancetype)kk_buttonWithType:(UIButtonType)buttonType title:(NSString *)title {
    KKLoginRegisButton *button = [KKLoginRegisButton buttonWithType:buttonType];
    button.enabled = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return button;
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if (enabled) {
        [self setBackgroundColor:KKCOLOR(255, 213, 0, 0.9)];
    } else {
        [self setBackgroundColor:KKCOLOR(249, 213, 111, 0.8)];
    }
}

@end
