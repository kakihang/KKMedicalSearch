//
//  KKCenterAnno.h
//  DePoint
//
//  Created by kaki on 16/7/28.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKCenterAnno : NSObject <MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;
@end
