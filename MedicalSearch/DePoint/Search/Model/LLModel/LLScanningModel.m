//
//  LLScanningModel.m
//  DePoint
//
//  Created by LZB on 16/8/14.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "LLScanningModel.h"

@implementation LLScanningModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"esArray": [LLScanningModel class]};
}
//+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
//    return @{@"ID": @"id"};
//}
@end
@implementation Esarray
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID": @"id"};
}
@end



