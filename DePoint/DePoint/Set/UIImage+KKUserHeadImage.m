//
//  UIImage+KKUserHeadImage.m
//  DePoint
//
//  Created by kaki on 16/8/16.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "UIImage+KKUserHeadImage.h"
#import "KKUserFileProc.h"


@implementation UIImage (KKUserHeadImage)

+ (instancetype)kk_getLoginUserIconWithFlag:(NSString *)user {
    if (user.length > 0) {
        return [UIImage imageNamed:@"feiting32"];
    } else {
        return [UIImage imageNamed:@"set_head_login_user"];
    }
}

@end
