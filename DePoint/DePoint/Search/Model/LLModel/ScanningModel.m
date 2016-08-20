//
//  ScanningModel.m
//  LZB_扫描
//
//  Created by LZB on 16/8/5.
//  Copyright © 2016年 LZB. All rights reserved.
//

#import "ScanningModel.h"

@implementation ScanningModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{ @"descr": @"description", @"ID": @"id"};
}
@end



