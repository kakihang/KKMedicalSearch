//
//  XPMediHclassTVCell.m
//  DePoint
//
//  Created by apple on 16/8/13.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "XPMediHclassTVCell.h"

@implementation XPMediHclassTVCell
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (NSMutableArray<UIButton *> *)xpClick {
    if(_xpClick == nil) {
        _xpClick = [NSMutableArray new];
        UIButton *c = nil;
        for(int i =0;i<4;i++){
            NSString *im = [NSString stringWithFormat:@"y%d",i + 1];
            XPButton *v =[XPButton buttonWithTitle:@"" imgName:im];
            CGFloat width = (self.contentView.bounds.size.width - 92) /4;
            [_xpClick addObject:v];
            [self.contentView addSubview:v];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(width).priorityHigh();
                make.height.equalTo(100).priorityHigh();
                make.top.equalTo(10);
                make.bottom.equalTo(-30);
                if(i==0){
                    make.left.equalTo(16);
                }else{
                    make.left.equalTo(c.mas_right).equalTo(20);
                    if(i==3){
                        make.right.equalTo(-16);
                    }
                }
            }];
            c = v;
        }
    }
    return _xpClick;
}


- (void)awakeFromNib {
    // Initialization code
}



@end
