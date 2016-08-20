//
//  KKCustomNavBarV.h
//  DeliveryPoint
//
//  Created by kaki on 16/7/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKCustomVCConstants.h"
//#import <DKNightVersion.h>

@interface KKCustomNavBarV : UIView


@property (nonatomic, weak) UIViewController *viewCtrlParent;

+ (CGRect)rightBtnFrame;
+ (CGSize)barBtnSize;
+ (CGSize)barSize;
+ (CGRect)titleViewFrame;

// 创建一个导航条按钮：使用默认的按钮图片。
+ (UIButton *)createNormalNaviBarBtnByTitle:(NSString *)strTitle target:(id)target action:(SEL)action;

// 创建一个导航条按钮：自定义按钮图片。
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight target:(id)target action:(SEL)action;
+ (UIButton *)createImgNaviBarBtnByImgNormal:(NSString *)strImg imgHighlight:(NSString *)strImgHighlight imgSelected:(NSString *)strImgSelected target:(id)target action:(SEL)action;

// 用自定义的按钮和标题替换默认内容
- (void)setLeftBtn:(UIButton *)btn;
- (void)setRightBtn:(UIButton *)btn;
- (void)setTitle:(NSString *)strTitle;
- (void)setNavBottomLineHidde:(BOOL)hide;
// add by kaki 增加夜间颜色设置
//- (void)setTitleDKColor:(DKColorPicker)dkColor;
- (void)setNavTintColor:(UIColor *)color;

// 设置右侧按钮标题
- (void)setRightBtnTitle:(NSString *)strTitle;
@end
