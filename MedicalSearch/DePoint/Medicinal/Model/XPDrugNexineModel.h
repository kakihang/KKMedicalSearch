//
//  XPDrugNexineModel.h
//  DePoint
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XPDrugNexineDataModel;
@interface XPDrugNexineModel : NSObject

@property (nonatomic, assign) BOOL status;

@property (nonatomic, strong) NSArray<XPDrugNexineDataModel *> *tngou;

@end
@interface XPDrugNexineDataModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *keywords;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger drugclass;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger seq;

@end

