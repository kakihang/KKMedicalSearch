//
//  NearConstant.h
//  DePoint
//
//  Created by kaki on 16/7/27.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#ifndef NearConstant_h
#define NearConstant_h


// 每隔多少米更新位置
static const NSInteger kkUpdateLocatoin_ = 50;
// 使用精度定位方式(kCLLocationAccuracyBest 最好)
#define KKACCURACY kCLLocationAccuracyBest
// 地图初始位置
//#define KKINITCOOR  CLLocationCoordinate2DMake(23.131287, 113.401946)
// 地图初始窗口大小
#define KKREGIONSPAN MKCoordinateSpanMake(0.021686, 0.014705)


#endif /* NearConstant_h */
