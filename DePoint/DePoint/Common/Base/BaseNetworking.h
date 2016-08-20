//
//  BaseNetworking.h
//  DePoint
//
//  Created by kaki on 16/7/22.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetworking : NSObject

+ (id)GET:(NSString *)path parameters:(NSDictionary *)parameters completionHandler:(void(^)(id repsonseObj, NSError *error))completionHandler;

+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters completionHandler:(void(^)(id repsonseObj, NSError *error))completionHandler;

+ (id)GET:(NSString *)path parameters:(NSDictionary *)parameters progress:(NSDictionary *)progress completionHandler:(void(^)(id repsonseObj, NSError *error))completionHandler;
@end
