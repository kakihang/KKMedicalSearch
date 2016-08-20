//
//  XPDetailModel.m
//  DePoint
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPDetailModel.h"

@implementation XPDetailModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"numbers":[XPDetailDataModel class],@"codes":[XPDetailCodesModel class]};
}
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"desc":@"description",@"ID":@"id"};
}
@end
@implementation XPDetailDataModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}
@end


@implementation XPDetailCodesModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}
@end


