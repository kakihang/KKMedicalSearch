//
//  KKSetViewModel.h
//  DePoint
//
//  Created by kaki on 16/8/4.
//  Copyright © 2016年 liudhkk. All rights reserved.
//


#import <Foundation/Foundation.h>


typedef void(^KKSetViewModelBlock)(id obj);

@interface KKSetViewModel : NSObject

- (NSInteger)getSectionNum;
- (NSInteger)getRowBySection:(NSInteger)section;
- (UIImage *)getIconByIndexPath:(NSIndexPath *)indexPath;
- (NSString *)getTitleByIndexPath:(NSIndexPath *)indexPath;
- (NSString *)getAssistByIndexPath:(NSIndexPath *)indexPath;
- (UIViewController *)getViewCtrlByIndexPath:(NSIndexPath *)indexPath;
- (KKSetViewModelBlock)getBlock:(NSIndexPath *)indexPath;

@end
