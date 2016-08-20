//
//  KKMedicineDataModel.h
//  DePoint
//
//  Created by kaki on 16/8/18.
//  Copyright © 2016年 liudhkk. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

@interface KKMedicineDataModel : BmobObject  <NSCoding>
@property (nonatomic, copy) NSString *userName;   // 用户标识,保存历史数据时必须输入,药盒数据不需填写
@property (nonatomic, copy) NSString *identifier; // 唯一标识,用于防重、删除，必须填写：13位商品码数据填写13位商品码，20位电子码数据填写20位电子码，药品分类查询和药名查询填写药品名
@property (nonatomic, copy) NSString *text;       // 选输
@property (nonatomic, copy) NSString *detailText; // 选输
@property (nonatomic, copy) NSString *icon;       // 选输
@property (nonatomic, copy) NSString *assistText; // 选输
@property (nonatomic, copy) NSString *assistIcon; // 选输
@property (nonatomic, copy) NSString *reamrk;     // 选输 备注
/** 以下为系统参数，不需赋值 **/
@property (nonatomic, copy) NSString *saveDate;     // 保存时间,不需填写,自动回填
@property (nonatomic, copy) NSString *sysUser;
@property (nonatomic, copy) NSString *sysId;
@end
