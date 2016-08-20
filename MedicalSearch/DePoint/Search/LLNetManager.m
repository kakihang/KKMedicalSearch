//
//  LLNetManager.m
//  DePoint
//
//  Created by LZB on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "LLNetManager.h"
#import "LLDefine.h"

@implementation LLNetManager
//13位
+ (id)getCode:(NSString *)page completionHandler:(void (^)(Esarray *, NSError *))completionHandler
{
    
    NSString *path = [NSString stringWithFormat:lScanning, page];
    
    return [self GET:path parameters:nil progress:nil completionHandler:^(id repsonseObj, NSError *error) {

        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *iso = [[NSString alloc] initWithData:repsonseObj encoding:enc];
        NSData *dutf8 = [iso dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *dict = [NSJSONSerialization JSONObjectWithData:dutf8 options:NSJSONReadingMutableContainers error:&error];
    
        !completionHandler ? :completionHandler([Esarray parse:dict],error);
        
        NSLog(@"------%@\n%@", dict, error);
    }];
}
//20位
+ (id)getcode:(NSString *)path completionHandler:(void (^)(ScanModel *, NSError *))completionHandler
{
    
    NSString *page = [NSString stringWithFormat:lScan, path];
    
    return [self GET:page parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        
        !completionHandler ? :completionHandler([ScanModel parse:repsonseObj],error);
    }];
}

@end
