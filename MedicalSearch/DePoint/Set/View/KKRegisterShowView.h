//
//  KKRegisterShowView.h
//  DePoint
//
//  Created by kaki on 16/8/11.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKLoginRegisButton.h"

@interface KKRegisterShowView : UIView

@property (nonatomic, weak) KKLoginRegisButton *registerButton; //
@property (nonatomic, weak) UITextField *phoneTf; //
@property (nonatomic, weak) UILabel *showPhoneLa; //
@property (nonatomic, weak) UIButton *sendAgain; //
@property (nonatomic, weak) UITextField *passVerifyTf; //

+ (instancetype)registerShowOnView:(UIView *)view index:(NSInteger)index;
@end
