//
//  UITextField+KKExtension.m
//  DePoint
//
//  Created by kaki on 16/8/11.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "UITextField+KKExtension.h"

@implementation UITextField (KKExtension)
+ (instancetype)kk_createWithPlaceholder:(NSString *)placeholder {
    UITextField *tf = [[UITextField alloc] init];
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.placeholder = placeholder;
    return tf;
}
+ (instancetype)kk_createPwdWithPlaceholder:(NSString *)placeholder {
    UITextField *tf = [[UITextField alloc] init];
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.placeholder = placeholder;
    tf.secureTextEntry = YES;
    return tf;
}
@end
