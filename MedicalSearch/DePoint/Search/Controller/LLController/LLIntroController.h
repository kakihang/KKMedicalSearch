//
//  LLIntroController.h
//  DePoint
//
//  Created by LZB on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLIntroController : UITableViewController

@property (nonatomic,readonly) NSString *str;

- (instancetype)initWithStr:(NSString *)str;

@end
