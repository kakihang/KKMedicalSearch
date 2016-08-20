//
//  KKUserFileProc.m
//  DePoint
//
//  Created by kaki on 16/8/19.
//  Copyright © 2016年 liudhkk. All rights reserved.
//


#import "KKUserFileProc.h"

@implementation KKUserFileProc

+ (void)kk_getUserIcon:(KKUserFileProcIconBlock)completionhandler {
    BmobUser *user = [BmobUser getCurrentUser];
    if (!user) {
        !completionhandler?:completionhandler(NO, nil, @"set_head_login_user");
    }
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];
    [bquery getObjectInBackgroundWithId:user.objectId block:^(BmobObject *object, NSError *error) {
        if (!error) {
            BmobFile *file1 = [object objectForKey:@"icon"];
            !completionhandler?:completionhandler(YES, nil, file1.url);
            if (!file1.url) {
                !completionhandler?:completionhandler(YES, nil, @"feiting32");
            }
        } else {
            !completionhandler?:completionhandler(NO, error, @"feiting32");
        }
    }];
}

//+ (void)kk_saveIcon:(KKUserFileProcIconBlock)completionhandler {
//    
//    NSBundle    *bundle = [NSBundle mainBundle];
//    NSString *fileString = [NSString stringWithFormat:@"%@/fei.png" ,[bundle bundlePath] ];
//    NSLog(@"%s: %@", __func__, fileString);
//    BmobObject *obj = [BmobObject objectWithoutDataWithClassName:@"_User" objectId:[BmobUser getCurrentUser].objectId];
//    BmobFile *file1 = [[BmobFile alloc] initWithFilePath:fileString];
//    
//    [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
//        //如果文件保存成功，则把文件添加到filetype列
//        if (isSuccessful) {
//            [obj setObject:file1  forKey:@"icon"];
//            //此处相当于新建一条记录,         //关联至已有的记录请使用 [obj updateInBackground];
//            [obj updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//                if (isSuccessful) {
//                    //打印file文件的url地址
//                    NSLog(@"file1 url %@",file1.url);
//                } else {
//                    NSLog(@"update %@", error);
//                }
//            }];
//        }else{
//            //进行处理
//            NSLog(@"%@", error);
//        }
//    }];
//}

@end
