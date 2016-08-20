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
        _fixed.contentMode = UIViewContentModeScaleAspectFill;

        [self.contentView addSubview:_fixed];
        [_fixed mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(20);
            make.left.equalTo(20);
            make.size.equalTo(CGSizeMake(105, 100));
        }];
    }
    return _fixed;
}

- (UILabel *)nameLb {
    if(_nameLb == nil) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(30);
            make.left.equalTo(self.fixed.right).equalTo(10);
            make.right.equalTo(-10);
            make.height.equalTo(30);
        }];

    }
    return _nameLb;
}

- (UILabel *)millLb {
    if(_millLb == nil) {
        _millLb = [[UILabel alloc] init];
        _millLb.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_millLb];
        [_millLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLb.bottom).equalTo(10);
            make.left.equalTo(self.nameLb);
            make.right.equalTo(-10);
            make.height.equalTo(30);
        }];
    }
    return _millLb;
}

- (UILabel *)codeLb {
    if(_codeLb == nil) {
        _codeLb = [[UILabel alloc] init];
        _codeLb.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_codeLb];
        [_codeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.millLb.bottom).equalTo(10);
            make.left.equalTo(self.millLb);
            make.right.equalTo(-10);
            make.height.equalTo(30);
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
            make.bottom.equalTo(-10);
            make.left.equalTo(10);
            make.height.equalTo(30);
            make.width.equalTo(200);
        }];
    }
    return _informationLb;
}

- (UIButton *)details {
    if(_details == nil) {
        _details = [[UIButton alloc] init];
        [self.contentView addSubview:_details];
        [_details mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(-10);
            make.size.equalTo(CGSizeMake(50, 30));
        }];
        
    }
    return _details;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
