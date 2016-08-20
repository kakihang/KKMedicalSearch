//
//  KKAboutViewC.m
//  DePoint
//
//  Created by kaki on 16/8/4.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKAboutViewC.h"



@implementation KKAboutViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"关于" tintColor:KKGLOTINTCOLOR backgroundColor:KKGLOBARCOLOR];
    
    // 中间图标
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-512"]];
    imageView.layer.cornerRadius = 20; //直接设置圆角
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_offset(-50);
        make.width.mas_equalTo(KKBWIDTHPRECENT(120));
        make.height.mas_equalTo(imageView.mas_width);
    }];
    
    // 底部的责任说明
    UILabel *dutyLa = [[UILabel alloc] init];
    dutyLa.textAlignment = NSTextAlignmentCenter;
    dutyLa.font = [UIFont systemFontOfSize:12];
    dutyLa.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    dutyLa.text = @"本软件仅供学习参考，不作商业用途";
    [self.view addSubview:dutyLa];
    [dutyLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
    
    // 底部的版本号
    UILabel *versionLa = [[UILabel alloc] init];
    versionLa.font = [UIFont systemFontOfSize:13];
    versionLa.textAlignment = NSTextAlignmentCenter;
    versionLa.textColor = [UIColor blackColor];
    versionLa.text = [NSString stringWithFormat:@"版本 V%@", [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]]; //当前版本号
    [self.view addSubview:versionLa];
    [versionLa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(dutyLa.mas_top).mas_equalTo(-5);
    }];
}

- (void)dealloc {
    NSLog(@"%s dealloc", __func__);
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    KKMedicineChestModel *m = [[KKMedicineChestModel alloc] init];
//    m.mcMode = KKMedicChModeDetail;
//    m.detail.medicName = @"风油精";
//    [KKSANBOX kk_saveMdeicChest:m];
//    
//    NSArray *arr = [KKSANBOX kk_getMdeicChest];
//    [arr enumerateObjectsUsingBlock:^(KKMedicineChestModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%@ %@", obj.detail.medicName, obj.saveDate);
//    }];
//}


@end
