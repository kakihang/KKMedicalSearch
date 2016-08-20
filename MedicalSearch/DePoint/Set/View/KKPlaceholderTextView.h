//
//  KKPlaceholderTextView.h
//  DePoint
//
//  Created by kaki on 16/8/5.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKPlaceholderTextView : UITextView
/** 占位字符 **/
@property (nonatomic, strong) NSString *placeholder;
/** 占位符文字颜色 **/
@property (nonatomic, strong) UIColor *placeholderColor;
@end
