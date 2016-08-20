//
//  KKSquareButton.m
//  8
//
//  Created by kaki on 16/6/22.
//  Copyright © 2016年 刘端杭. All rights reserved.
//

#import "KKSquareButton.h"

@implementation KKSquareButton
- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitleColor:[UIColor colorWithWhite:0.3 alpha:1] forState:(UIControlStateNormal)];
    [self setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
}

+ (instancetype)buttonWithTitle:(NSString *)title {
    KKSquareButton *button = [[KKSquareButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title imgName:(NSString *)imgName {
    KKSquareButton *button = [self buttonWithTitle:title];
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    return button;
}

+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title {
    KKSquareButton *button = [[KKSquareButton alloc] initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.y = self.height * 0.2;
    self.imageView.width = self.width * 0.8;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}



@end
