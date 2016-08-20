//
//  LLScanningModel.h
//  DePoint
//
//  Created by LZB on 16/8/14.
//  Copyright © 2016年 liudhkk. All rights reserved.
//
//13位
#import <Foundation/Foundation.h>

@class Esarray;
@interface LLScanningModel : NSObject

@property (nonatomic, strong) NSArray<Esarray *> *esArray;

@end

@interface Esarray : NSObject
//id->ID
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *drugId;

@property (nonatomic, copy) NSString *manuId;

@property (nonatomic, copy) NSString *turnRatio;

@property (nonatomic, copy) NSString *packUom;

@property (nonatomic, copy) NSString *goodsManu;

@property (nonatomic, copy) NSString *standard;

@property (nonatomic, copy) NSString *packageNorm;

@property (nonatomic, copy) NSString *drugEname;

@property (nonatomic, copy) NSString *passNum;

@property (nonatomic, copy) NSString *leastUom;

@property (nonatomic, copy) NSString *drugName;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, copy) NSString *form;

@property (nonatomic, copy) NSString *barCode;

@property (nonatomic, copy) NSString *drugShortName;

@property (nonatomic, copy) NSString *standardCode;

@property (nonatomic, copy) NSString *status;
@end


