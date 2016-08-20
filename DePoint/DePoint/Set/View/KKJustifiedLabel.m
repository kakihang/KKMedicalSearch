//
//  KKJustifiedLabel.m
//  DePoint
//
//  Created by kaki on 16/8/11.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKJustifiedLabel.h"

@implementation KKJustifiedLabel {
    BOOL _attrFlag;
}

+ (instancetype)kk_labelWithText:(NSString *)text {
    KKJustifiedLabel *label = [[KKJustifiedLabel alloc] init];
    label.font = [UIFont systemFontOfSize:16];
    label.text = text;
    return label;
}
- (void)setText:(NSString *)text {
    [super setText:text];
    _attrFlag = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!_attrFlag) {
        _attrFlag = YES;
        [self kk_textAlignmentJustified];
    }
}

- (void)kk_textAlignmentJustified {
    
    NSString *currentString = self.text;
    CGRect rect = [[currentString substringToIndex:1] boundingRectWithSize:CGSizeMake(self.frame.size.width,self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.font} context:nil];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:currentString];
    
    CGFloat strLength = [self getLengthOfString:currentString];
    
    NSInteger maxInteger = (self.frame.size.width) / (rect.size.width);
    [attrString addAttribute:NSKernAttributeName value:@((maxInteger - strLength) * (rect.size.width)/(strLength - 1)) range:NSMakeRange(0, strLength-1)];
    self.attributedText = attrString;
    
}

-  (CGFloat)getLengthOfString:(NSString*)str {
    CGFloat strLength = 0;
    char *p = (char *)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (NSInteger i = 0 ; i < [str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            strLength++;
        }
        p++;
    }
    return strLength/2;
}




@end
