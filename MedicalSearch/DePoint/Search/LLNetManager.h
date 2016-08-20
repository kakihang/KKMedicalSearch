//
//  LLNetManager.h
//  DePoint
//
//  Created by LZB on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetworking.h"
#import "ScanningModel.h"
#import "ScanModel.h"
#import "LLScanningModel.h"
@interface LLNetManager : BaseNetworking
//13位
+ (id)getCode:(NSString *)page completionHandler:(void(^)(Esarray *model,NSError *error))completionHandler;
//20位
+ (id)getcode:(NSString *)path completionHandler:(void(^)(ScanModel *model,NSError *error))completionHandler;
@end
