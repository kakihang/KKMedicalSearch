//
//  AppDelegate.m
//  DePoint
//
//  Created by kaki on 16/7/22.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#import "AppDelegate.h"
#import "KKFrameTabC.h"
#import <UMMobClick/MobClick.h>
#import <AFNetworkActivityIndicatorManager.h>

// Bmob
#import <BmobSDK/Bmob.h>

// 高德地图框架
#import <AMapFoundationKit/AMapFoundationKit.h>

// shareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <SMS_SDK/SMSSDK.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import "TencentOpenAPI/TencentOAuth.h"
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
/*#import "WeiboSDK.h"*/
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*****************************************************************/
    // 高德地图apiKey
    [AMapServices sharedServices].apiKey = KKGDMAPAPIKEY;
    
    /*****************************************************************/
    // 显示网络菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    // 显示网络连接状态
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%@", AFStringFromNetworkReachabilityStatus(status));
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    /*****************************************************************/
    [SMSSDK registerApp:KKSMSAPIKEY withSecret:KKSMSSCREKEY];
    
    /*****************************************************************/
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:KKSHAREAPIKEY
          activePlatforms:@[
                            /*@(SSDKPlatformTypeSinaWeibo),*/
                            @(SSDKPlatformTypeMail),
                            /*@(SSDKPlatformTypeSMS),*/
                            /*@(SSDKPlatformTypeCopy),*/
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
                 /*case SSDKPlatformTypeSinaWeibo:
                  [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                  break;*/
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             default:
                 break;
         }
     } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
         switch (platformType) {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 /*[appInfo SSDKSetupSinaWeiboByAppKey:@""
                  appSecret:@""
                  redirectUri:@"http://sns.whalecloud.com/sina2/callback"
                  authType:SSDKAuthTypeBoth];
                  break;*/
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:KKQQAPIID
                                      appKey:KKQQAPIKEY
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:KKWXAPIID
                                       appSecret:KKWXAPIKEY];
                 break;
             default:
                 break;
         }
     }];
    
    /*****************************************************************/
    // bmob 数据存储
    [Bmob registerWithAppKey:KKBMOBAPIKEY];
    
    /*****************************************************************/
    // 友盟数据统计
    UMConfigInstance.appKey = KKUMAPIKEY;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setLogEnabled:YES]; // 不拦截本地错误日志

    /*****************************************************************/
    
    [MLTransition validatePanBackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    /*****************************************************************/
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[KKFrameTabC alloc] init];
    [self.window makeKeyAndVisible];
    NSLog(@"%@", NSStringFromCGRect([UIScreen mainScreen].bounds));
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options
{
    return [TencentOAuth HandleOpenURL:url];
}


@end
