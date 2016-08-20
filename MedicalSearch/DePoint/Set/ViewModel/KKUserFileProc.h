//
//  KKUserFileProc.h
//  DePoint
//
//  Created by kaki on 16/8/19.
//  Copyright © 2016年 liudhkk. All rights reserved.
//
typedef void(^KKUserFileProcIconBlock)(BOOL isSuccessful, NSError *error, NSString *url);
#import <Foundation/Foundation.h>

@interface KKUserFileProc : NSObject

+ (void)kk_getUserIcon:(KKUserFileProcIconBlock)completionhandler;

@end
