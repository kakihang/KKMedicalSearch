//
//  KKColumnButtons.m
//  DePoint
//
//  Created by kaki on 16/8/2.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKColumnButtons.h"


@interface KKColumnButtons()

@property (nonatomic, strong) NSMutableArray <UIButton *> *buttonArr;
@property (nonatomic, strong) UILabel *alertLabel;
@end


@implementation KKColumnButtons {
    BOOL hiddenFlag;
}

- (instancetype)init {
    NSAssert1(NO, @"%s: 请使用 initWithMode:direction: 进行初始化", __func__);
    return nil;
}

- (instancetype)initWithMode:(KKColunmMode)columnMode direction:(KKColunmDirection)direction {
    if (self = [super init]) {
        _direction = direction;
        _columnMode = columnMode;
    }
    return self;
}

- (void)kk_createColumns:(NSArray *)columnArr {
    if (columnArr.count <= 0) {
        NSAssert1(NO, @"%s: 输入参数不正确", __func__);
    }
    
    UIView *spview = [self superview];
    UIButton *lastButton = self;
    if (self.columnMode == KKColunmModeStore) {
        [lastButton setTitle:columnArr[0] forState:UIControlStateNormal];
    } else {
        [lastButton setTitle:[NSString stringWithFormat:@"范围%@米", columnArr[0]] forState:UIControlStateNormal];
    }
    [lastButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [lastButton setBackgroundImage:[UIImage imageNamed:@"clumnsBG"] forState:UIControlStateNormal];
    [lastButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [lastButton addTarget:self action:@selector(showColumn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonArr removeAllObjects];
    
    for (int i=0; i<columnArr.count-1; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:columnArr[i+1] forState:UIControlStateNormal];
        
        [button setBackgroundImage:[UIImage imageNamed:@"tomclimber_time_back"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [button bk_addEventHandler:^(id sender) {
            [self kk_setButtonArrHidden:YES];
            if (self.columnMode == KKColunmModeStore) {
                [self setTitle:columnArr[i+1] forState:UIControlStateNormal];
            } else {
                [self setTitle:[NSString stringWithFormat:@"范围%@米", columnArr[i+1]] forState:UIControlStateNormal];
            }
            [self.kk_columnButtonDeledate kk_touchColumn:self button:button title:columnArr[i+1] atIndex:i];
        } forControlEvents:UIControlEventTouchUpInside];
        [spview addSubview:button];
        
        switch (self.direction) {
            case KKColunmDirectionTop: {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.height.mas_equalTo(lastButton);
                    make.bottom.mas_equalTo(lastButton.mas_top);
                }];
                break;
            }
            case KKColunmDirectionBottom: {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.height.mas_equalTo(lastButton);
                    make.top.mas_equalTo(lastButton.mas_bottom);
                }];
                break;
            }
        }
        
        
        [self.buttonArr addObject:button];
        lastButton = button;
    }
    
    if (self.columnMode == KKColunmModeRange) {
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.text = @"支持显示附近最多50个";
        _alertLabel.textColor = KKCOLOR(100, 100, 100, 0.9);
        [_alertLabel setFont:[UIFont systemFontOfSize:12]];
        [spview addSubview:_alertLabel];
        [_alertLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(lastButton);
            make.centerX.mas_equalTo(lastButton);
        }];
        switch (self.direction) {
            case KKColunmDirectionTop: {
                [_alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(lastButton.mas_top);
                }];
                break;
            }
            case KKColunmDirectionBottom: {
                [_alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(lastButton.mas_bottom);
                }];
                break;
            }
        }
    }
    
    hiddenFlag = YES;
    [self kk_setButtonArrHidden:hiddenFlag];
}


- (void)showColumn:(UIButton *)button {
    hiddenFlag = !hiddenFlag;
    [self kk_setButtonArrHidden:hiddenFlag];
}

- (void)kk_setButtonArrHidden:(BOOL)flag {
    hiddenFlag = flag;
    _alertLabel.hidden = flag;
    [self.buttonArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isHidden != flag) {
            obj.hidden = flag;
        }
    }];
}


- (NSMutableArray <UIButton *> *)buttonArr {
    if(_buttonArr == nil) {
        _buttonArr = [[NSMutableArray <UIButton *> alloc] init];
    }
    return _buttonArr;
}

@end
