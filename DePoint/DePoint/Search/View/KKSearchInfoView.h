//
//  KKSearchInfoView.h
//  DePoint
//
//  Created by LZB on 16/8/21.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKSearchInfoView : UIView

@property (nonatomic) UILabel *inquiry;//查询次数

@property (nonatomic) UILabel *time;//首次查询

@property (nonatomic) NSMutableArray<UIImageView *> *go;

- (instancetype)init;

@end
