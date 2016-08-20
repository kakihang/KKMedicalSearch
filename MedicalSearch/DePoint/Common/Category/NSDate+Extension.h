//
//  NSDate+Extension.h
//  DePoint
//
//  Created by kaki on 16/7/22.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
- (NSDateComponents *)deltaFrom:(NSDate *)from;
- (NSDateComponents *)deltaFrom:(NSString *)fromDate format:(NSString *)format;
- (NSString *)getBigUnitFrom:(NSString *)fromDate format:(NSString *)format;

- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;

// 传入自1970以来的秒数，返回日期字符串，具体格式请参考代码
+ (NSString *)kk_stringTimeFromSeconds:(NSTimeInterval)time;

// 获取当前日期，按传入格式初始化，并返回
+ (NSString *)kk_currentDatebyFormat:(NSString *)format;

@end
