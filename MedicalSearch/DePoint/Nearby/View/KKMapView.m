//
//  KKMapView.m
//  DePoint
//
//  Created by kaki on 16/7/28.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKMapView.h"

@implementation KKMapView

+ (instancetype)mapViewWithFram:(CGRect)frame {
    KKMapView *mapView = [[KKMapView alloc] initWithFrame:frame];
    mapView.userLocation.title = @"我的位置";
    return mapView;
}

@end
