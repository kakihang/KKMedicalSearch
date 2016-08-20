//
//  KKLocationVModel.h
//  DePoint
//
//  Created by kaki on 16/7/27.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLLocationManager+KKModel.h"
#import "AMapPOIAroundSearchRequest+KKModel.h"
#import "KKCenterAnno.h"
#import "KKMapView.h"
// 地图框架
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface KKLocationVModel : NSObject

- (instancetype)initWithMapView:(MKMapView *)mapView;

// 开始搜索
- (void)setSearchDelegate:(id)vc;
- (void)startSearch;
- (void)startSearchWithCoordinate:(CLLocationCoordinate2D)coordinnate;

- (void)setKeywords:(NSString *)keywords;
- (void)setRadius:(NSInteger)radius;

// 当前位置
@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;
- (void)setCoordinate:(CLLocationCoordinate2D)coordinnate;




// 大头针:搜索中心点
@property (nonatomic, strong, readonly) KKCenterAnno *centerAnno;
- (void)changeCenterAnno:(CLLocationCoordinate2D)coordinate;

@end
