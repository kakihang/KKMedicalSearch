//
//  XPSearchModel.m
//  DePoint
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPSearchModel.h"

@implementation XPSearchModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id",@"desc":@"description"};
}
@end
