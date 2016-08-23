//
//  LLIntroCell.m
//  DePoint
//
//  Created by LZB on 16/8/16.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "LLIntroCell.h"

@implementation LLIntroCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self fixed];
        [self nameLb];
        [self millLb];
        [self codeLb];
        [self informationLb];
        [self details];
        
    }
    return self;
}
- (UIImageView *)fixed {
    if(_fixed == nil) {
        _fixed = [[UIImageView alloc] init];
        [self.contentView addSubview:_fixed];
        [_fixed mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(40);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(105, 80)).priorityHigh();
        }];
    }
    return _fixed;
}

- (UILabel *)nameLb {
    if(_nameLb == nil) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = [UIFont systemFontOfSize:19];
        [self.contentView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(30);
            make.left.equalTo(self.fixed.mas_right).equalTo(20);
            make.right.equalTo(-10);
            make.height.equalTo(20);
        }];

    }
    return _nameLb;
}

- (UILabel *)millLb {
    if(_millLb == nil) {
        _millLb = [[UILabel alloc] init];
        _millLb.font = [UIFont systemFontOfSize:15];
        _millLb.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
        [self.contentView addSubview:_millLb];
        [_millLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLb.mas_bottom).equalTo(15);
            make.left.equalTo(self.nameLb);
            make.right.equalTo(-10);
            make.height.equalTo(20);
        }];
    }
    return _millLb;
}

- (UILabel *)codeLb {
    if(_codeLb == nil) {
        _codeLb = [[UILabel alloc] init];
        _codeLb.font = [UIFont systemFontOfSize:15];
        _codeLb.textColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
        [self.contentView addSubview:_codeLb];
        [_codeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.millLb.mas_bottom).equalTo(5);
            make.left.equalTo(self.millLb);
            make.right.equalTo(-10);
            make.height.equalTo(50);
        }];
    }
    return _codeLb;
}

- (UILabel *)informationLb {
    if(_informationLb == nil) {
        _informationLb = [[UILabel alloc] init];
        _informationLb.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_informationLb];
        [_informationLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fixed.mas_bottom).equalTo(30);
            make.left.equalTo(20);
            make.height.equalTo(30);
        }];
    }
    return _informationLb;
}

- (UIButton *)details {
    if(_details == nil) {
        _details = [[UIButton alloc] init];
        [self.contentView addSubview:_details];
        [_details mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.top.equalTo(self.informationLb);
            make.size.equalTo(CGSizeMake(50, 30));
        }];
        
    }
    return _details;
}

- (UISegmentedControl *)btn {
    if(_btn == nil) {
        _btn = [[UISegmentedControl alloc] init];
        NSArray *headline = [[NSArray alloc]initWithObjects:@"药品信息",@"药品流向",nil];
        _btn = [[UISegmentedControl alloc]initWithItems:headline];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName,nil, nil];
        [_btn setTitleTextAttributes:attributes forState:UIControlStateNormal];
        _btn.tintColor = [UIColor colorWithRed:67.0 / 256.0 green:185.0 / 256.0 blue:188.0 / 256.0 alpha:1.0];
        _btn.selectedSegmentIndex = 0;
        [self.contentView addSubview:_btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fixed.mas_bottom).equalTo(30);
            make.left.equalTo(20);
            make.right.equalTo(-20);
            make.height.equalTo(35);
        }];
    }
    return _btn;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
