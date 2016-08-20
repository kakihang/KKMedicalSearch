//
//  ScanModel.h
//  DePoint
//
//  Created by LZB on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//
//20位

#import <Foundation/Foundation.h>

@class Info;
@interface ScanModel : NSObject

@property (nonatomic, strong) Info *info;

@end

@interface Info : NSObject

@property (nonatomic, copy) NSString *expiry_date;

@property (nonatomic, assign) NSInteger retcode;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *issue_expiry;

@property (nonatomic, copy) NSString *pkg_spec;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *license_number;

@property (nonatomic, copy) NSString *thumb_url;

@property (nonatomic, copy) NSString *production_date;

@property (nonatomic, copy) NSString *sale_time;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *ref_id;

@property (nonatomic, copy) NSString *last_ent;

@property (nonatomic, copy) NSString *first_query;

@property (nonatomic, copy) NSString *sale_ent;

@property (nonatomic, copy) NSString *specifications;

@property (nonatomic, assign) BOOL expired;

@property (nonatomic, assign) NSInteger query_time;

@property (nonatomic, copy) NSString *manufacturer;

@property (nonatomic, copy) NSString *last_time;

@property (nonatomic, copy) NSString *prepn_type;

@property (nonatomic, copy) NSString *prepn_unit;

@property (nonatomic, assign) NSInteger production_batch;

@property (nonatomic, copy) NSString *pkg_unit;

@property (nonatomic, copy) NSString *flow;

@property (nonatomic, assign) BOOL is_sale;

@end





