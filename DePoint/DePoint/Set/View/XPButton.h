//
//  XPButton.h
//  DePoint
//
//  Created by apple on 16/8/10.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPButton : UIButton
+ (instancetype)buttonWithTitle:(NSString *)title;
+ (instancetype)buttonWithTitle:(NSString *)title imgName:(NSString *)imgName;
+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title;
@end
