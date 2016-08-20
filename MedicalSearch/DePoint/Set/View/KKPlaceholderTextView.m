//
//  KKPlaceholderTextView.m
//  DePoint
//
//  Created by kaki on 16/8/5.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKPlaceholderTextView.h"


@interface KKPlaceholderTextView()
@property (nonatomic, weak) UILabel *label;
@end


@implementation KKPlaceholderTextView

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        label.hidden = NO;
        label.x = 4;
        label.y = 7;
        label.numberOfLines = 2;
        [self addSubview:label];
        self.label = label;
    }
    return _label;
}

- (instancetype)init {
    if (self = [super init]) {
        // 垂直方向上永远有弹簧效果(设置后，子控件才有效果)
        self.alwaysBounceVertical = YES;
        
        self.font = [UIFont systemFontOfSize:13];
        
        // 获取通知事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        // 垂直方向上永远有弹簧效果(设置后，子控件才有效果)
//        self.alwaysBounceVertical = YES;
//        
//        self.font = [UIFont systemFontOfSize:15];
//        
//        // 获取通知事件
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
//    }
//    return self;
//}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidChange {
    // 只要有文字，则隐藏label
    self.label.hidden = self.hasText;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.width = self.width - 2*self.label.x;
    [self.label sizeToFit];
}


- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.label.text = placeholder;
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.label.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.label.font = font;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self textDidChange];
}

@end
