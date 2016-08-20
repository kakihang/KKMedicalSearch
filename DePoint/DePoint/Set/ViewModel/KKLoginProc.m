//
//  KKLoginProc.m
//  DePoint
//
//  Created by kaki on 16/8/14.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "KKLoginProc.h"
#import <BmobSDK/Bmob.h>

@implementation KKLoginProc

+ (void)kk_logout {
    [BmobUser logout];
}

+ (NSString *)kk_getCurrentUser {
    BmobUser *bUser = [BmobUser getCurrentUser];
    return bUser.username;
}

+ (NSString *)kk_getCurrentPhone {
    BmobUser *bUser = [BmobUser getCurrentUser];
    return bUser.mobilePhoneNumber;
}

+ (void)kk_registerWithPhone:(NSString *)phone complehandler:(void(^)(BOOL isSuccessful, NSError *error))complehandler {
    BmobUser *bUser = [[BmobUser alloc] init];
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];
    [bquery whereKey:@"mobilePhoneNumber" equalTo:phone];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error) {
            NSLog(@"查询成功: %@", array);
            NSString *password;
            if (array.count == 0) {
                [bUser setUsername:phone];
                password = phone.loginString;
                [bUser setPassword:password];
                [bUser setObject:@NO forKey:@"isPasswordLogin"];
                [bUser setObject:@YES forKey:@"mobilePhoneNumberVerified"];
                [bUser setObject:phone forKey:@"mobilePhoneNumber"];
                [bUser setObject:password forKey:@"pass"];
                [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
                    if (isSuccessful){
                        NSLog(@"注册成功");
                        [BmobUser loginInbackgroundWithAccount:phone andPassword:password block:^(BmobUser *user, NSError *error) {
                            if (user) {
                                NSLog(@"登录成功: %@",user);
                                !complehandler?:complehandler(YES, error);
                            } else {
                                NSLog(@"登录失败: %@",error);
                                !complehandler?:complehandler(NO, error);
                            }
                        }];
                    } else {
                        NSLog(@"注册失败:%@ ", error);
                        !complehandler?:complehandler(isSuccessful, error);
                    }
                }];
            } else {
                password = [[array firstObject] objectForKey:@"pass"];
                [BmobUser loginInbackgroundWithAccount:phone andPassword:password block:^(BmobUser *user, NSError *error) {
                    if (user) {
                        NSLog(@"%@",user);
                        !complehandler?:complehandler(YES, error);
                    } else {
                        NSLog(@"%@",error);
                        !complehandler?:complehandler(NO, error);
                    }
                }];
            }
        } else {
            NSLog(@"查询失败");
            !complehandler?:complehandler(NO, error);
        }
    }];
}


+ (void)kk_registerWithPhone:(NSString *)phone password:(NSString *)password complehandler:(void(^)(BOOL isSuccessful, NSError *error))complehandler {
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];
    [bquery whereKey:@"mobilePhoneNumber" equalTo:phone];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error) {
            NSLog(@"查询成功: %@", array);
            BmobUser *bUser = [[BmobUser alloc] init];
            if (array.count == 0) {
                [bUser setUsername:phone];
                [bUser setPassword:password];
                [bUser setObject:@YES forKey:@"isPasswordLogin"];
                [bUser setObject:@YES forKey:@"mobilePhoneNumberVerified"];
                [bUser setObject:phone forKey:@"mobilePhoneNumber"];
                [bUser setObject:password forKey:@"pass"];
                [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
                    if (isSuccessful){
                        NSLog(@"注册成功");
                        [BmobUser loginInbackgroundWithAccount:phone andPassword:password block:^(BmobUser *user, NSError *error) {
                            if (user) {
                                NSLog(@"登录成功: %@",user);
                                !complehandler?:complehandler(YES, error);
                            } else {
                                NSLog(@"登录失败: %@",error);
                                !complehandler?:complehandler(NO, error);
                            }
                        }];
                    } else {
                        NSLog(@"注册失败:%@ ", error);
                        !complehandler?:complehandler(isSuccessful, error);
                    }
                }];
            } else {
                NSString *oldPassword = [[array firstObject] objectForKey:@"pass"];
                [BmobUser loginInbackgroundWithAccount:phone andPassword:oldPassword block:^(BmobUser *user, NSError *error) {
                    if (user) {
                        NSLog(@"旧密码登录成功 %@",user);
                        [user updateCurrentUserPasswordWithOldPassword:oldPassword newPassword:password block:^(BOOL isSuccessful, NSError *error) {
                            if (isSuccessful) {
                                [BmobUser loginInbackgroundWithAccount:phone andPassword:password block:^(BmobUser *user, NSError *error) {
                                    if (error) {
                                        NSLog(@"login error:%@",error);
                                        !complehandler?:complehandler(NO, error);
                                    } else {
                                        BmobUser *bUser = [BmobUser getCurrentUser];
                                        [bUser setObject:@YES forKey:@"isPasswordLogin"];
                                        [bUser setObject:password forKey:@"pass"];
                                        [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                                            !complehandler?:complehandler(isSuccessful, error);
                                        }];
                                        NSLog(@"user:%@",user);
                                        !complehandler?:complehandler(YES, error);
                                    }
                                }];
                            } else {
                                !complehandler?:complehandler(NO, error);
                                NSLog(@"change password error:%@",error);
                            }
                        }];
                        
                        !complehandler?:complehandler(YES, error);
                    } else {
                        NSLog(@"处理失败 %@",error);
                        !complehandler?:complehandler(NO, error);
                    }
                }];
            }
        } else {
            NSLog(@"查询失败");
            !complehandler?:complehandler(NO, error);
        }
    }];
}

+ (void)kk_changePassAndLoginWithPhone:(NSString *)phone newPassword:(NSString *)newPassword complehandler:(void(^)(BOOL isSuccessful, NSError *error))complehandler {
    __weak typeof(self) weakSelf = self;
    [BmobUser loginWithUsernameInBackground:phone password:phone.loginString block:^(BmobUser *user, NSError *error) {
        if (error) {
            !complehandler?:complehandler(NO, error);
        } else {
            [weakSelf kk_updateCurrentUserPasswordWithOldPassword:phone.loginString newPassword:newPassword complehandler:^(NSError *error) {
                !complehandler?:complehandler(NO, error);
            }];
        }
    }];
}

+ (void)kk_updateCurrentUserPasswordWithOldPassword:(NSString *)oldPassword
                                        newPassword:(NSString *)newPassword
                                      complehandler:(void(^)(NSError *error))complehandler {
    BmobUser *user = [BmobUser getCurrentUser];
    [user updateCurrentUserPasswordWithOldPassword:oldPassword newPassword:newPassword block:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [BmobUser loginInbackgroundWithAccount:user.username andPassword:newPassword block:^(BmobUser *user, NSError *error) {
                !complehandler?:complehandler(error);
            }];
        } else {
            !complehandler?:complehandler(error);
        }
    }];
}


+ (void)kk_checkPhoneExist:(NSString *)phone complehandler:(void(^)(NSError *error, BOOL isExist))complehandler {
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"_User"];
    [bquery whereKey:@"mobilePhoneNumber" equalTo:phone];
    [bquery whereKey:@"isPasswordLogin" equalTo:@YES];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        !complehandler?:complehandler(error, array.count>0);
    }];
}


+ (void)kk_loginWithAccount:(NSString *)account
                   password:(NSString *)password
              complehandler:(void(^)(NSError *error))complehandler {
    [BmobUser loginInbackgroundWithAccount:account andPassword:password block:^(BmobUser *user, NSError *error) {
        !complehandler?:complehandler(error);
    }];
}

+ (void)kk_changeUserName:(NSString *)newName complehandler:(void(^)(NSError *error))complehandler {
    BmobUser *bUser = [BmobUser getCurrentUser];
    [bUser setObject:newName forKey:@"username"];
    [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        !complehandler?:complehandler(error);
    }];
}
+ (void)kk_changeUserPasswordWithOldPass:(NSString *)oldPassword newPass:(NSString *)newPass complehandler:(void(^)(NSError *error, NSString *errMsg))complehandler {
    BmobUser *user = [BmobUser getCurrentUser];
    __weak typeof(self) weakSelf = self;
    [user updateCurrentUserPasswordWithOldPassword:oldPassword newPassword:newPass block:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [BmobUser loginInbackgroundWithAccount:user.mobilePhoneNumber andPassword:newPass block:^(BmobUser *user, NSError *error) {
                !complehandler?:complehandler(error, [weakSelf errorCode:error]);
            }];
        } else {
            !complehandler?:complehandler(error, [weakSelf errorCode:error]);
        }
    }];
}

+ (NSString *)errorCode:(NSError *)error {
    if (!error) {
        return nil;
    }
    switch (error.code) {
        case 210:
            return @"当前密码不正确，请重新输入";
        case 141:
        case 20002:
            return @"网络连接失败";
        default:
            return @"处理失败";
    }
}

+ (void)kk_thirdLoginWithDictionary:(NSDictionary *)dict platform:(id)platform complehandler:(void(^)(NSError *error, NSString *username))complehandler {
    [BmobUser loginInBackgroundWithAuthorDictionary:dict platform:BmobSNSPlatformQQ block:^(BmobUser *user, NSError *error) {
        if (error) {
            NSLog(@"user login error:%@",error);
        } else if (user){
            NSLog(@"user objectid is :%@",user.objectId);
        }
        !complehandler?:complehandler(error, user.username);
    }];
}


@end
