//
//  KKMedicineDataHandle.m
//  DePoint
//
//  Created by kaki on 16/8/18.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKMedicineDataHandle.h"
#import <BmobSDK/Bmob.h>

@interface KKMedicineDataHandle()
@property (atomic, strong) NSMutableDictionary *allDataDict;
@end



@implementation KKMedicineDataHandle

- (instancetype)init {
    NSCAssert1(NO, @"%p: 请直接使用宏定义:KKMEDICINEDATA调用实例方法，如 [KKMEDICINEDATA kk_getSanBoxWithUserName:@\"username\"]; ", __func__);
    return nil;
}

// 归档
- (void)saveToSanBox:(id)obj path:(NSString *)path {
    [NSKeyedArchiver archiveRootObject:obj toFile:path];
    //    NSLog(@"%@", path);
}
// 解档
- (id)getFromSanBox:(NSString *)path {
    //    NSLog(@"%@", path);
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
// 历史数据路径
- (NSString *)getPathWithUserName:(NSString *)userName {
    return [NSString stringWithFormat:@"%@/KKSAVE.%@.plist", KKCACHEPATH, userName];
}
// 更新缓存
- (void)updateAllDataCache:(id)obj key:(NSString *)key {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{ // 更新缓存
        //        [self.allDataDict removeObjectForKey:key]; 会自动覆盖
        [self.allDataDict setObject:obj forKey:key];
    });
}
// 更新沙盒
- (void)updateSanBox:(id)obj key:(NSString *)key {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self saveToSanBox:obj path:[self getPathWithUserName:key]];
    });
}


/**
 *  @author liudhkk, 16-08-18 15:08:09
 *
 *  单例
 */
static KKMedicineDataHandle *dataHandler_ = nil;
+ (instancetype)shareData {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (dataHandler_ == nil) {
            dataHandler_ = [[KKMedicineDataHandle alloc] initShare];
            dataHandler_.allDataDict = [[NSMutableDictionary alloc] init];
        }
    });
    return dataHandler_;
}
- (instancetype)initShare {
    return [super init];
}

/**
 *  @author liudhkk, 16-08-18 15:08:19
 *
 *  保存到沙盒数据，适用于历史数据
 *
 *  @param userName
 *  @param identifier
 *  @param text
 *  @param detailText
 *  @param iconUrl
 *  @param remark
 */
- (void)kk_saveSanBoxWithUser:(NSString *)userName
                   identifier:(NSString *)identifier
                         text:(NSString *)text
                   detailText:(NSString *)detailText
                      iconUrl:(NSString *)iconUrl
                       remark:(NSString *)remark {
    if (!userName) {
        NSAssert1(NO, @"%s: userName不能为空", __func__);
        return;
    }
    
    KKMedicineDataModel *model = [[KKMedicineDataModel alloc] init];
    model.userName = userName;
    model.identifier = identifier;
    model.text = text;
    model.detailText = detailText;
    model.icon = iconUrl;
    model.reamrk = remark;
    [self kk_saveSanBoxWithDataModel:model];
}

- (void)kk_saveSanBoxWithDataModel:(KKMedicineDataModel *)medicineDataModel {
    if (!medicineDataModel.userName) {
        NSAssert1(NO, @"%s: userName不能为空", __func__);
        return;
    }
    
    // 设置添加日期
    medicineDataModel.saveDate = [NSDate kk_currentDatebyFormat:@"yyyy-MM-dd"];
    
    NSArray <KKMedicineDataModel *> *array = [self kk_getSanBoxWithUserName:medicineDataModel.userName];
    // 判断是否为空
    NSMutableArray <KKMedicineDataModel *> *tmp = [NSMutableArray array];
    if (array) { // 如果不为空，添加元素
        if (medicineDataModel.identifier) { // 防重
            [array enumerateObjectsUsingBlock:^(KKMedicineDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj.identifier isEqualToString:medicineDataModel.identifier]) {
                    [tmp addObject:obj];
                }
            }];
        }
        [tmp insertObject:medicineDataModel atIndex:0];
    } else { // 如果为空，添加数组
        tmp = [NSMutableArray arrayWithObject:medicineDataModel];
    }
    
    
    
    // 更新缓存、沙盒
    [self updateAllDataCache:tmp.copy key:medicineDataModel.userName];
    [self updateSanBox:tmp.copy key:medicineDataModel.userName];
}

/**
 *  @author liudhkk, 16-08-18 15:08:25
 *
 *  从沙盒删除单条历史数据
 *
 *  @param userNmae
 *  @param identifier
 */
- (void)deleteFromSanBoxWithUserName:(NSString *)userNmae
                          identifier:(NSString *)identifier {
    __block BOOL updateFlag = NO;
    NSMutableArray <KKMedicineDataModel *> *tmp = [self kk_getSanBoxWithUserName:userNmae].mutableCopy;
    [tmp enumerateObjectsUsingBlock:^(KKMedicineDataModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:identifier]) {
            [tmp removeObjectAtIndex:idx];
            *stop = YES;
            updateFlag = YES;
        }
    }];
    if (updateFlag) {
        [self updateAllDataCache:tmp.copy key:userNmae];
        [self updateSanBox:tmp.copy key:userNmae];
    }
}
/**
 *  @author liudhkk, 16-08-18 15:08:35
 *
 *  从沙盒删除多条历史数据
 *
 *  @param userNmae
 *  @param identifierArray
 */
- (void)deleteFromSanBoxWithUserName:(NSString *)userNmae
                     identifierArray:(NSArray *)identifierArray {
    [identifierArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self deleteFromSanBoxWithUserName:userNmae identifier:obj];
    }];
    
}

/**
 *  @author liudhkk, 16-08-18 15:08:32
 *
 *  保存到沙盒数据，适用于历史数据
 *
 *  @param userName
 *
 *  @return
 */
- (NSArray <KKMedicineDataModel *> *)kk_getSanBoxWithUserName:(NSString *)userName {
    if (!userName) {
        NSLog(@"%p :userName 不能为空", __func__);
        return nil;
    }
    NSArray *arr = self.allDataDict[userName];
    if (!arr) {
        arr = [self getFromSanBox:[self getPathWithUserName:userName]];
        if (arr) {
            [self.allDataDict setObject:arr forKey:userName];
        }
    }
#warning mark 排序?
    if (arr) { // 排序
        
    }
    
    return arr;
}

/**
 *  @author liudhkk, 16-08-18 09:08:24
 *
 *  保存到用户云存储
 *  @param identify           唯一标识,必须填写 见KKMedicineDataModel.h
 *  @param text               选输
 *  @param detailText         选输
 *  @param iconUrl            选输
 *  @param remark             选输
 *  @param complectionHandler 选输
 */
- (void)kk_saveMedicineChestWithIdentify:(NSString *)identify
                                    text:(NSString *)text
                              detailText:(NSString *)detailText
                                 iconUrl:(NSString *)iconUrl
                                  remark:(NSString *)remark
                      complectionHandler:(block)complectionHandler {
    if (!identify) {
        NSAssert1(NO, @"%p: identify不允许为空", __func__);
    }
    KKMedicineDataModel *model = [[KKMedicineDataModel alloc] init];
    model.identifier = identify;
    model.text = text;
    model.detailText = detailText;
    model.icon = iconUrl;
    model.reamrk = remark;
    [self kk_saveMedicineChestWithModel:model complectionHandler:^(NSError *error, NSString *errMsg) {
        !complectionHandler?:complectionHandler(error, errMsg);
    }];
}
- (void)kk_saveMedicineChestWithModel:(KKMedicineDataModel *)medicineDataModel
                   complectionHandler:(block)complectionHandler {
    BmobUser *user = [BmobUser getCurrentUser];
    medicineDataModel.sysUser = user.username;
    medicineDataModel.sysId = user.objectId;
    [medicineDataModel sub_saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        !complectionHandler?:complectionHandler(error, error?nil:@"处理失败");
    }];
}

/**
 *  @author liudhkk, 16-08-18 17:08:38
 *
 *  从网络删除单个元素
 *
 *  @param identifier
 *  @param complectionHandler
 */
- (void)deleteMedicineChestWithIdentifier:(NSString *)identifier
                       complectionHandler:(block)complectionHandler {
    if (!identifier) {
        NSLog(@"%p: identifier 为空", __func__);
        return;
    }
    [self deleteMedicineChestWithIdentifierArray:@[identifier] complectionHandler:^(NSError *error, NSString *errMsg) {
        !complectionHandler?:complectionHandler(error, errMsg);
    }];
}

/**
 *  @author liudhkk, 16-08-18 20:08:37
 *
 *  批量删除药盒数据，每次最多允许处理50条
 *
 *  @param identifierArray     唯一标识数组
 *  @param complectionHandler
 */
- (void)deleteMedicineChestWithIdentifierArray:(NSArray *)identifierArray
                            complectionHandler:(block)complectionHandler {
    if (identifierArray.count <=0 ) {
        NSLog(@"%p: identifierArray 为空", __func__);
        return;
    } else if (identifierArray.count > 50) {
        NSAssert1(NO, @"%p :每次最多允许处理50条数据", __func__);
    }
    
    
    BmobUser *user = [BmobUser getCurrentUser];
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"KKMedicineDataModel"];
    [bquery whereKey:@"sysId" equalTo:user.objectId];
    [bquery whereKey:@"identifier" containedIn:[NSArray arrayWithArray:identifierArray]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            !complectionHandler?:complectionHandler(error, error?nil:@"处理失败");
        }
        
        if (array.count > 0) {
            __block BmobObjectsBatch *batch = [[BmobObjectsBatch alloc] init];
            [array enumerateObjectsUsingBlock:^(BmobObject * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [batch deleteBmobObjectWithClassName:@"GameScore" objectId:[obj objectForKey:@"playerName"]];
            }];
            [batch batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                NSLog(@"batch error %@",[error description]);
            }];
        }
    }];
}

/**
 *  @author liudhkk, 16-08-18 09:08:09
 *
 *  从网络获取药盒数据
 *
 *  @return 返回数据组数，根据时间排序
 */
- (void)kk_getMedicineChestComplectionHandler:(kk_queryNetWorkBlock)complectionHandler {
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"KKMedicineDataModel"];
    BmobUser *user = [BmobUser getCurrentUser];
    [bquery whereKey:@"sysId" equalTo:user.objectId];
    [bquery orderByDescending:@"createdAt"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error) {
            NSMutableArray *arr = [NSMutableArray array];
            for (KKMedicineDataModel *obj in array) {
                [arr addObject:obj];
            }
            !complectionHandler?:complectionHandler(arr.copy, nil);
        } else {
            !complectionHandler?:complectionHandler(nil, error);
        }
    }];
}



@end
