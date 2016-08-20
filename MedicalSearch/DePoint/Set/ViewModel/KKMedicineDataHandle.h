//
//  KKMedicineDataHandle.h
//  DePoint
//
//  Created by kaki on 16/8/18.
//  Copyright © 2016年 liudhkk. All rights reserved.
//
typedef void(^block)(NSError *error, NSString *errMsg);
typedef void(^kk_queryNetWorkBlock)(NSArray *objArr, NSError *error);
#define KKMEDICINEDATA [KKMedicineDataHandle shareData]


#import <Foundation/Foundation.h>
#import "KKMedicineDataModel.h"

@interface KKMedicineDataHandle : NSObject


- (instancetype)init;

/**
 *  @author liudhkk, 16-08-18 10:08:55
 *
 *  单例
 *
 *  @return 
 */
+ (instancetype)shareData;

/**
 *  @author liudhkk, 16-08-18 09:08:52
 *
 *  保存到沙盒数据，适用于历史数据
 *
 *  @param userName    用户标识,保存历史数据时必须输入,药盒数据不需填写
 *  @param identifier  唯一标识,必须填写 见KKMedicineDataModel.h
 *  @param text        选输
 *  @param detailText  选输
 *  @param iconUrl     选输
 *  @param remark      选输
 */
- (void)kk_saveSanBoxWithUser:(NSString *)userName
                   identifier:(NSString *)identifier
                         text:(NSString *)text
                   detailText:(NSString *)detailText
                      iconUrl:(NSString *)iconUrl
                       remark:(NSString *)remark;
- (void)kk_saveSanBoxWithDataModel:(KKMedicineDataModel *)medicineDataModel;

/**
 *  @author liudhkk, 16-08-18 09:08:09
 *
 *  根据userName从沙盒获取所有历史数据
 *
 *  @param userName 用户标识，以此来存取数据
 *
 *  @return 返回数据组数，根据时间从近到远排序
 */
- (NSArray <KKMedicineDataModel *> *)kk_getSanBoxWithUserName:(NSString *)userName;

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
                      complectionHandler:(block)complectionHandler;
- (void)kk_saveMedicineChestWithModel:(KKMedicineDataModel *)medicineDataModel
                   complectionHandler:(block)complectionHandler;


/**
 *  @author liudhkk, 16-08-18 15:08:25
 *
 *  从沙盒删除单条历史数据
 *
 *  @param userNmae
 *  @param identifier
 */
- (void)deleteFromSanBoxWithUserName:(NSString *)userNmae
                          identifier:(NSString *)identifier;
/**
 *  @author liudhkk, 16-08-18 15:08:35
 *
 *  从沙盒删除多条历史数据
 *
 *  @param userNmae
 *  @param identifierArray
 */
- (void)deleteFromSanBoxWithUserName:(NSString *)userNmae
                     identifierArray:(NSArray *)identifierArray;


/**
 *  @author liudhkk, 16-08-18 17:08:38
 *
 *  从网络删除单个元素
 *
 *  @param identifier
 *  @param complectionHandler
 */
- (void)deleteMedicineChestWithIdentifier:(NSString *)identifier
                       complectionHandler:(block)complectionHandler;

/**
 *  @author liudhkk, 16-08-18 20:08:37
 *
 *  批量删除药盒数据，每次最多允许处理50条
 *
 *  @param identifierArray     唯一标识数组
 *  @param complectionHandler
 */
- (void)deleteMedicineChestWithIdentifierArray:(NSArray *)identifierArray
                            complectionHandler:(block)complectionHandler;


/**
 *  @author liudhkk, 16-08-18 09:08:09
 *
 *  从网络获取药盒数据
 *
 *  @return 返回数据组数，根据时间排序
 */
- (void)kk_getMedicineChestComplectionHandler:(kk_queryNetWorkBlock)complectionHandler;

@end
