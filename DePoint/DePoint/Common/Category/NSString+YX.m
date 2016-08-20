//
//  NSString+YX.m
//  TRProject
//
//  Created by tarena on 16/7/13.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "NSString+YX.h"

@implementation NSString (YX)
- (NSURL *)yx_URL{
    return [NSURL URLWithString:self];
}

- (NSString *)loginString {
    NSString *tmp = self.copy;
    return  [[tmp hmacMD5StringWithKey:self.md5String] hmacMD5StringWithKey:@".kk.2016.08."];
}

- (NSString *)kk_phoneEncrypt {
    if (self.length == 11) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(3, 4)withString:@"****"];
    } else {
        NSLog(@"%p error: [%@]phone.length is not equal to 11", __func__, self);
        return self;
    }
}

@end
