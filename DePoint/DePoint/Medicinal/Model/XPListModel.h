//
//  XPListModel.h
//  DePoint
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XPListDataModel;
@interface XPListModel : NSObject

@property (nonatomic, assign) BOOL status;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, strong) NSArray<XPListDataModel *> *tngou;

@end
@interface XPListDataModel : NSObject

@property (nonatomic, assign) NSInteger fcount;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger rcount;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *keywords;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *name;

@end

