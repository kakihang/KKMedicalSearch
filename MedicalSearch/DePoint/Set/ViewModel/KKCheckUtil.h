//
//  KKCheckUtil.h
//  DePoint
//
//  Created by kaki on 16/8/13.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKCheckUtil : NSObject
+ (BOOL) isStrEmpty:(NSString*)string;

+ (void) showAlertWithMessage:(NSString*)message delegate:(id)delegate;
@end
