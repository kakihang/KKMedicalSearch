//
//  XPNetManager.m
//  DePoint
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPNetManager.h"

@implementation XPNetManager
+(id)getDrugscompletionHandler:(void (^)(XPDrugsModel *, NSError *))completionHandler{
    return [self GET:kDurgPath parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !completionHandler ? : completionHandler([XPDrugsModel parse:repsonseObj],error);
    }];
}
+(id)getNexine:(NSInteger)page completionHandler:(void (^)(XPDrugNexineModel *, NSError *))completionHandler{
    NSString *path =[NSString stringWithFormat:KNexinePath,page];
    return [self GET:path parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !completionHandler ? : completionHandler([XPDrugNexineModel parse:repsonseObj],error);
    }];
}
+(id)getList:(NSInteger)page more:(NSInteger)more completionHandler:(void (^)(XPListModel *, NSError *))completionHandler{
    NSString *path =[NSString stringWithFormat:KListPath,page,more];
    return [self GET:path parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !completionHandler ? : completionHandler([XPListModel parse:repsonseObj],error);
    }];
}
+(id)getDetail:(NSInteger)page completionHandler:(void (^)(XPDetailModel *, NSError *))completionHandler{
    NSString *path =[NSString stringWithFormat:KDetailPath,page];
    return [self POST:path parameters:nil completionHandler:^(id repsonseObj, NSError *error) {
        !completionHandler ? : completionHandler([XPDetailModel parse:repsonseObj],error);
    }];
}
+(id)getSearch:(NSString *)path completionHandler:(void (^)(XPSearchModel *, NSError *))completionHandler{
    if(path.length ==0){
        !completionHandler ? :completionHandler(nil,nil);
        return nil;
    }
    NSString *page = [NSString stringWithFormat:kNamePath,path];
    page = [page stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:path forKey:@"name"];
    return [self POST:page parameters:params completionHandler:^(id repsonseObj, NSError *error) {
        NSLog(@"-------%@",page);
        !completionHandler ?:completionHandler([XPSearchModel parse:repsonseObj],error);
    }];
}


@end
