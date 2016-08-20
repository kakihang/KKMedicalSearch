//
//  KKSetViewModel.m
//  DePoint
//
//  Created by kaki on 16/8/4.
//  Copyright © 2016年 liudhkk. All rights reserved.
//
#import "KKSetViewModel.h"
#import "KKAboutViewC.h"
#import "KKFeedBackVC.h"
#import "KKCustomVC.h"
#import "KKMedicineChestVC.h"
#import "KKLoginProc.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>





@interface KKSetViewModel()

@property (nonatomic, strong) NSArray <NSArray *> *dataList; // 数据样式
@end




@implementation KKSetViewModel

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

-(NSInteger)getSectionNum {
    return self.dataList.count;
}
- (NSInteger)getRowBySection:(NSInteger)section {
    return self.dataList[section].count;
}

- (UIImage *)getIconByIndexPath:(NSIndexPath *)indexPath {
    return [UIImage imageNamed:self.dataList[indexPath.section][indexPath.row][@"icon"]];
}

- (NSString *)getTitleByIndexPath:(NSIndexPath *)indexPath {
    return self.dataList[indexPath.section][indexPath.row][@"title"];
}

- (NSString *)getAssistByIndexPath:(NSIndexPath *)indexPath {
    typedef NSString*(^cacheBlock)(void);
    cacheBlock cachec = self.dataList[indexPath.section][indexPath.row][@"assist"];
    if (cachec) {
        return cachec();;
    }
    
    return nil;
}

- (UIViewController *)getViewCtrlByIndexPath:(NSIndexPath *)indexPath {
    return self.dataList[indexPath.section][indexPath.row][@"viewController"];
}

- (KKSetViewModelBlock)getBlock:(NSIndexPath *)indexPath {
    return self.dataList[indexPath.section][indexPath.row][@"block"];
}


#pragma mark - 懒加载

- (NSArray *)dataList {
    if(_dataList == nil) {
        __weak typeof(self) weakSelf = self;
        _dataList =
        @[@[@{@"icon":@"set_icon",  //0-0
              @"title":@"药箱",
              @"block":^(UIViewController *obj){
                  if (![KKLoginProc kk_getCurrentUser]) {
                      [obj.view kk_showAlertNoTitleWithMessage:@"请先进行登录"];
                  } else {
                      [weakSelf pushViewContr:[[KKMedicineChestVC alloc] init] from:obj];
                  }
              }
              }/*,
                @{@"icon":@"set_icon",  //0-1
                @"title":@"收藏"}*/],
          
          @[@{@"icon":@"set_icon",  //1-0
              @"title":@"清除缓存",
              @"assist":^(void){
                  return [weakSelf getCacheRoom];
              },
              @"block":^(UITableViewController *obj){
                  [weakSelf deleteCache:obj];
                  [obj.tableView reloadData];
              }}],
          
          @[@{@"icon":@"set_icon",  //2-1
              @"title":@"推荐给朋友",
              @"block":^(id obj){
                  [weakSelf shareToFriends];
              }},
            @{@"icon":@"set_icon",  //2-2
              @"title":@"给我评分",
              @"block":^(id obj){[[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app%@", KKAPPLESTOREADDRESS]]];}},
            @{@"icon":@"set_icon", //2-3
              @"title":@"意见反馈",
              @"block":^(id obj){
                  [weakSelf pushViewContr:[[KKFeedBackVC alloc] init] from:obj];
              }}],
          
          @[@{@"icon":@"set_icon",  //3-1
              @"title":@"关于",
              @"block":^(id obj){
                  [weakSelf pushViewContr:[[KKAboutViewC alloc] init] from:obj];
              }}]];
    }
    return _dataList;
}

- (void)pushViewContr:(UIViewController *)toVC from:(UIViewController *)fromVC {
    fromVC.hidesBottomBarWhenPushed = YES;
    toVC.view.backgroundColor = KKGLOBAL;
    [fromVC.navigationController pushViewController:toVC animated:YES];
    fromVC.hidesBottomBarWhenPushed = NO;
}

- (NSString *)getCacheRoom {
    NSInteger totalSize = 0;
    NSFileManager *manager = [NSFileManager defaultManager];
    // 拼接缓存路径文件
    NSString *cachePath = KKCACHEPATH;
    NSLog(@"缓存路径%@", cachePath);
    
    // 计算指定目录所有文件总大小
    // 遍历指定目录所有文件(包括子目录)
    NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:cachePath];
    for (NSString *filename in enumerator) {
        NSString *path = [cachePath stringByAppendingPathComponent:filename];
        
        // 获取文件信息
        NSDictionary *fileInfo = [manager attributesOfItemAtPath:path error:nil];
        // 判断是否为目录
        if ([fileInfo[NSFileType] isEqualToString:NSFileTypeDirectory]) {
            continue;
        }
        NSInteger size = [fileInfo[NSFileSize] integerValue];
        totalSize += size;
    }
    
    // 获取的大小按1000进位，而不是1024
    NSLog(@"准确计算所有文件缓存大小%zd", totalSize);
    return [NSString stringWithFormat:@"%.2lfM", totalSize/1000/1000.0];
}

- (void)deleteCache:(UITableViewController *)vc {
    NSError *error;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:KKCACHEPATH];
    for (NSString *filename in enumerator) {
        NSString *path = [KKCACHEPATH stringByAppendingPathComponent:filename];
        [manager removeItemAtPath:path error:&error];
        if (error) {
            NSLog(@"%s: %@", __func__, error);
            break;
        }
    }
    [vc.view showWarning:@"清理完成~"];
}

- (void)shareToFriends {
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:[NSString stringWithFormat:@"itunes.apple.com/cn/app%@", KKAPPLESTOREADDRESS]]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state,
                                         SSDKPlatformType platformType,
                                         NSDictionary *userData,
                                         SSDKContentEntity *contentEntity,
                                         NSError *error,
                                         BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess: {
                               [UIView kk_showAlertNoTitleWithMessage:@"分享成功"];
                               break;
                           }
                           case SSDKResponseStateFail: {
                               [UIView kk_showAlertNoTitleWithMessage:@"分享失败"];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
}
@end
