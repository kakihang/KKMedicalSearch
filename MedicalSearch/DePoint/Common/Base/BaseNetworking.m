//
//  BaseNetworking.m
//  DePoint
//
//  Created by kaki on 16/7/22.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "BaseNetworking.h"

@implementation BaseNetworking
+ (id)GET:(NSString *)path parameters:(NSDictionary *)parameters completionHandler:(void (^)(id, NSError *))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    
    return [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", task.currentRequest.URL.absoluteString);
        !completionHandler?:completionHandler(responseObject, nil);
        
        [[NSOperationQueue new] addOperationWithBlock:^{
            // 做缓存
            NSString *cachePath = [NSString stringWithFormat:@"%@.%@", KKNETWORKCACHESPATH, task.currentRequest.URL.absoluteString.md5String];
            [NSKeyedArchiver archiveRootObject:responseObject toFile:cachePath];
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", task.currentRequest.URL.absoluteString);
        NSLog(@"%@", error);
        
        [[NSOperationQueue new] addOperationWithBlock:^{
            // 读缓存
            NSString *cachePath = [NSString stringWithFormat:@"%@.%@", KKNETWORKCACHESPATH, task.currentRequest.URL.absoluteString.md5String];
            id responseObj = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (responseObj) {
                    !completionHandler?:completionHandler(responseObj, nil);
                } else {
                    !completionHandler ?: completionHandler(nil, error);
                }
            }];
        }];
    }];
    
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters completionHandler:(void (^)(id, NSError *))completionHandler{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    return [manager POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", task.currentRequest.URL.absoluteString);
        !completionHandler?:completionHandler(responseObject, nil);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", task.currentRequest.URL.absoluteString);
        NSLog(@"%@", error);
        !completionHandler ?: completionHandler(nil, error);
        
    }];
    
}

+(id)GET:(NSString *)path parameters:(NSDictionary *)parameters progress:(NSDictionary *)progress completionHandler:(void (^)(id, NSError *))completionHandler
{
    //增加这几行代码；
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    //这里进行设置；
    [manager setSecurityPolicy:securityPolicy];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    return [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        !completionHandler?:completionHandler(responseObject, nil);
        [[NSOperationQueue new] addOperationWithBlock:^{
            // 做缓存
            NSString *cachePath = [KKNETWORKCACHESPATH stringByAppendingPathComponent:task.currentRequest.URL.absoluteString.md5String];
            [NSKeyedArchiver archiveRootObject:responseObject toFile:cachePath];
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [[NSOperationQueue new] addOperationWithBlock:^{
            // 读缓存
            NSString *cachePath = [KKNETWORKCACHESPATH stringByAppendingPathComponent:task.currentRequest.URL.absoluteString.md5String];
            id responseObj = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (responseObj) {
                    !completionHandler?:completionHandler(responseObj, nil);
                } else {
                    !completionHandler ?: completionHandler(nil, error);
                }
            }];
        }];
    }];
}

@end
