//
//  XPDetailController.h
//  DePoint
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPDetailController : UITableViewController
-(instancetype)initWithDetai:(NSInteger)idnt;
@property(nonatomic,readonly)NSInteger idnt;
@end
