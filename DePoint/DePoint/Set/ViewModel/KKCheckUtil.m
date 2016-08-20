//
//  KKCheckUtil.m
//  DePoint
//
//  Created by kaki on 16/8/13.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKCheckUtil.h"

@implementation KKCheckUtil
+ (BOOL) isStrEmpty:(NSString*)string{
    if (!string || [string isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

+ (void) showAlertWithMessage:(NSString*)message delegate:(id)delegate{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

@end
