//
//  LLIntroBelowCell.m
//  DePoint
//
//  Created by LZB on 16/8/10.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "LLIntroBelowCell.h"

@implementation LLIntroBelowCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self division];
        [self formLb];
        [self packuomLb];
        [self standardLb];
        [self passnumLb];
    }
    return self;
}

- (UIView *)division {
    if(_division == nil) {
        _division = [[UIView alloc] init];
        [self.contentView addSubview:_division];
        [_division mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(0);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.height.equalTo(2);
        }];
    }
    return _division;
}

- (UILabel *)reminder {
    if(_reminder == nil) {
        _reminder = [[UILabel alloc] init];
        _reminder.numberOfLines = 0;
        _reminder.font = [UIFont systemFontOfSize:15];
        _reminder.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
        [self.contentView addSubview:_reminder];
        [_reminder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.division.mas_bottom).equalTo(10);
            make.left.equalTo(20);
            make.right.equalTo(-20);
            make.height.equalTo(80).priorityHigh();
        }];
    }
    return _reminder;
}

- (UILabel *)formLb {
    if(_formLb == nil) {
        _formLb = [[UILabel alloc] init];
        _formLb.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_formLb];
        [_formLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.reminder.mas_bottom).equalTo(20);
            make.left.equalTo(20);
            make.right.equalTo(-10);
            make.height.equalTo(20);
        }];
    }
    return _formLb;
}

- (UILabel *)packuomLb {
    if(_packuomLb == nil) {
        _packuomLb = [[UILabel alloc] init];
        _packuomLb.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_packuomLb];
        [_packuomLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.formLb.mas_bottom).equalTo(20);
            make.left.equalTo(self.formLb);
            make.right.equalTo(-10);
            make.height.equalTo(20);
        }];
    }
    return _packuomLb;
}

- (UILabel *)standardLb {
    if(_standardLb == nil) {
        _standardLb = [[UILabel alloc] init];
        _standardLb.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_standardLb];
        [_standardLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.packuomLb.mas_bottom).equalTo(20);
            make.left.equalTo(self.formLb);
            make.right.equalTo(-10);
            make.height.equalTo(20);
        }];
    }
    return _standardLb;
}

- (UILabel *)passnumLb {
    if(_passnumLb == nil) {
        _passnumLb = [[UILabel alloc] init];
        _passnumLb.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_passnumLb];
        [_passnumLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.standardLb.mas_bottom).equalTo(20);
            make.left.equalTo(self.formLb);
            make.right.equalTo(-10);
            make.height.equalTo(20);
        }];
    }
    return _passnumLb;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
