//
//  BaseViewModel.h
//  DePoint
//
//  Created by kaki on 16/7/22.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RequestMode) {
    RequestModeRefresh,
    RequestModeMore,
};

@interface BaseViewModel : NSObject
@property (nonatomic) NSURLSessionDataTask *dataTask;
- (void)getDataWithMode:(RequestMode)requestMode completionHandler:(void(^)(NSError *error))completionHandler;
@end
