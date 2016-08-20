//
//  XPDrugsModel.m
//  DePoint
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPDrugsModel.h"

@implementation XPDrugsModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"tngou":[XPDrugsDataModel class]};
}
@end
@implementation XPDrugsDataModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id",@"desc":@"description"};
}
@end


