//
//  XPFactory.h
//  DePoint
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPFactory : NSObject

+(void)addSearchItemForVC:(UIViewController *)vc clickedHandler:(void(^)())handler;
@end
