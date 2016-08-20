//
//  NSObject+Parse.h
//  TRProject
//
//  Created by tarena on 16/7/13.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#define KKCodingDescription \
- (void)encodeWithCoder:(NSCoder *)aCoder { \
[self modelEncodeWithCoder:aCoder]; \
} \
- (instancetype)initWithCoder:(NSCoder *)aDecoder { \
self = [super init]; \
return [self modelInitWithCoder:aDecoder]; \
} \
-(NSString *)description { \
return [self modelDescription]; \
}



#import <Foundation/Foundation.h>

@interface NSObject (Parse)<YYModel>

+ (id)parse:(id)JSON;

@end
