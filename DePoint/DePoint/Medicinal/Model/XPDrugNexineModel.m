//
//  XPDrugNexineModel.m
//  DePoint
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPDrugNexineModel.h"

@implementation XPDrugNexineModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"tngou":[XPDrugNexineDataModel class]};
}
@end
@implementation XPDrugNexineDataModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id",@"desc":@"description"}; 
}
@end


