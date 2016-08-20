//
//  XPSearchModel.h
//  DePoint
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPSearchModel : NSObject
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger fcount;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) BOOL status;

@property (nonatomic, assign) NSInteger count;

//@property (nonatomic, strong) NSArray<Data *> *numbers;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *keywords;

@property (nonatomic, strong) NSArray *codes;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger rcount;


@end
//@interface Data : NSObject
//
//@property (nonatomic, assign) NSInteger drug;
//
//@property (nonatomic, copy) NSString *factory;
//
//@property (nonatomic, assign) NSInteger id;
//
//@property (nonatomic, copy) NSString *number;
//
//@end



