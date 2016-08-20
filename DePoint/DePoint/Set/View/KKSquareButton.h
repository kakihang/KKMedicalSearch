//
//  KKSquareButton.h
//  8
//
//  Created by kaki on 16/6/22.
//  Copyright © 2016年 刘端杭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKSquareButton : UIButton

+ (instancetype)buttonWithTitle:(NSString *)title;
+ (instancetype)buttonWithTitle:(NSString *)title imgName:(NSString *)imgName;
+ (instancetype)buttonWithFrame:(CGRect)frame title:(NSString *)title;

@end
