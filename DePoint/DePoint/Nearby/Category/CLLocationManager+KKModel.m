//
//  CLLocationManager+KKModel.m
//  DePoint
//
//  Created by kaki on 16/7/27.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "CLLocationManager+KKModel.h"

@implementation CLLocationManager (KKModel)
+ (instancetype)manager {
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.desiredAccuracy = KKACCURACY;
    manager.distanceFilter = kkUpdateLocatoin_;
    if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [manager requestWhenInUseAuthorization];
    }
    
    return manager;
}
@end
