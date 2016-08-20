//
//  XPMediTClassTVCell.h
//  DePoint
//
//  Created by apple on 16/8/13.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XPMedCellClickDelegate <NSObject>

-(void)cellClickIndex:(NSInteger)index;

@end

@interface XPMediTClassTVCell : UITableViewCell
@property (nonatomic, strong) UIButton *firstBt;
@property (nonatomic, strong) UIButton *secondBt;
@property (nonatomic, strong) UIButton *thirdBt;

@property(nonatomic,weak) id<XPMedCellClickDelegate> XPCellClickDelegate;
@end
