//
//  ScanningModel.h
//  LZB_扫描
//
//  Created by LZB on 16/8/5.
//  Copyright © 2016年 LZB. All rights reserved.
//
//13位
#import <Foundation/Foundation.h>

@interface ScanningModel : NSObject
//description->descr
@property (nonatomic, copy) NSString *descr;

@property (nonatomic, assign) NSInteger fcount;
//id->ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) BOOL status;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *factory;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *keywords;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger rcount;

@end
