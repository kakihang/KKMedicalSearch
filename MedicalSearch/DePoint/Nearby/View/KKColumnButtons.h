//
//  KKColumnButtons.h
//  DePoint
//
//  Created by kaki on 16/8/2.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

typedef NS_ENUM(NSUInteger, KKColunmMode) {
    KKColunmModeStore,
    KKColunmModeRange,
};

typedef NS_ENUM(NSUInteger, KKColunmDirection) {
    KKColunmDirectionTop,
    KKColunmDirectionBottom,
};


#import <UIKit/UIKit.h>
@class KKColumnButtons;

@protocol KKColumnButtonDelegate <NSObject>
- (void)kk_touchColumn:(KKColumnButtons *)column button:(UIButton *)button title:(NSString *)title atIndex:(NSInteger)index;
@end


@interface KKColumnButtons : UIButton

@property (nonatomic, readonly) KKColunmDirection direction;
- (instancetype)initWithMode:(KKColunmMode)columnMode direction:(KKColunmDirection)direction;

@property (nonatomic, readonly) KKColunmMode columnMode;
- (void)kk_createColumns:(NSArray *)columnArr;
@property (nonatomic, strong) id <KKColumnButtonDelegate> kk_columnButtonDeledate;  // 代理


- (void)kk_setButtonArrHidden:(BOOL)flag;

@end
