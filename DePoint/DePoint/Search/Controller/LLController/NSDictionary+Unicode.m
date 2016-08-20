//
//  NSDictionary+Unicode.m
//  DePoint
//
//  Created by LZB on 16/8/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "NSDictionary+Unicode.h"

@implementation NSDictionary (Unicode)
- (NSString*)my_description{
    NSString *desc = [self my_description];
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}
@end
