//
//  XPListModel.m
//  DePoint
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPListModel.h"

@implementation XPListModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"tngou":[XPListDataModel class]};
}
@end
@implementation XPListDataModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id",@"desc":@"description"};
}
@end


