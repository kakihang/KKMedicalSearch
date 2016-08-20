//
//  NSDate+Extension.m
//  DePoint
//
//  Created by kaki on 16/7/22.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
// 比较两个日期时间data,返回相差的时间
- (NSDateComponents *)deltaFrom:(NSDate *)from {
    if (!from) {
        return nil;
    }
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}


// 根据传入日期，与指定格式日期相差的时间
- (NSDateComponents *)deltaFrom:(NSString *)fromDate format:(NSString *)format {
    if (!fromDate || !format) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [self deltaFrom:[formatter dateFromString:fromDate]];
}


// 根据传入日期，与指定格式日期相差时间，返回最大单位
- (NSString *)getBigUnitFrom:(NSString *)fromDate format:(NSString *)format {
    NSDateComponents *cp = [self deltaFrom:fromDate format:format];
    if (cp.year != 0) {
        return [NSString stringWithFormat:@"%zd年", cp.year];
    } else if (cp.month != 0) {
        return [NSString stringWithFormat:@"%zd月", cp.month];
    } else if (cp.day != 0) {
        return [NSString stringWithFormat:@"%zd日", cp.day];
    } else if (cp.hour != 0) {
        return [NSString stringWithFormat:@"%zd小时", cp.hour];
    } else if (cp.minute != 0) {
        return [NSString stringWithFormat:@"%zd分", cp.minute];
    } else {
        return [NSString stringWithFormat:@"%zd秒", cp.second];
    }
}

#pragma mark 时间


- (BOOL)isThisYear {
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 比较时间
    NSInteger nowYear = [calendar component:(NSCalendarUnitYear) fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:(NSCalendarUnitYear) fromDate:[NSDate date]];
    
    return nowYear == selfYear;
}

- (BOOL)isToday {
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [matter stringFromDate:[NSDate date]];
    NSString *selfStr = [matter stringFromDate:self];
    
    return [selfStr isEqualToString:nowStr];
}

- (BOOL)isYesterday {
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [matter dateFromString:[matter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [matter dateFromString:[matter stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmp.year==0 && cmp.month==0 && cmp.day==1;
}

+ (NSString *)kk_stringTimeFromSeconds:(NSTimeInterval)time {
    
    // 时间转换
    NSDateFormatter *mat = [[NSDateFormatter alloc] init];
    mat.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    if ([date isThisYear]) { // 当年
        if ([date isToday]) { // 当天
            NSDateComponents *component = [[NSDate date] deltaFrom:date];
            if (component.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", component.hour];
            } else if (component.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前", component.minute];
            } else {
                return @"刚刚";
            }
        } else if ([date isYesterday]) { // 昨天
            mat.dateFormat = @"HH";
            return [NSString stringWithFormat:@"昨天%@点", [mat stringFromDate:date]];
        } else {
            mat.dateFormat = @"MM-dd";
            return [NSString stringWithFormat:@"%@", [mat stringFromDate:date]];
        }
    } else { // 非当年
        mat.dateFormat = @"yyyy-MM-dd";
        return [NSString stringWithFormat:@"%@", [mat stringFromDate:date]];
    }
    
}


+ (NSString *)kk_currentDatebyFormat:(NSString *)format {
    NSDateFormatter *mat = [[NSDateFormatter alloc] init];
    mat.dateFormat = format;
    return [mat stringFromDate:[NSDate date]];
}

@end
