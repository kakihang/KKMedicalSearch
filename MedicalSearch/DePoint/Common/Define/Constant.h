//
//  Constant.h
//  DePoint
//
//  Created by kaki on 16/7/22.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

/** 全局参数 **/

// title字体大小
#define KKGlobalTitleTextFont  [UIFont systemFontOfSize:15]
// detail字体大小
#define KKGlobalDetailTextFont [UIFont systemFontOfSize:14]
// min字体大小
#define KKGlobalMinTextFont [UIFont systemFontOfSize:14]
// tabBar字体大小
#define KKTabBarTextFont [UIFont systemFontOfSize:10]

// 三原色和透明度 颜色宏
#define KKCOLOR(kred, kgreen, kblue, kalpha) [UIColor colorWithRed:kred/255.0 green:kgreen/255.0 blue:kblue/255.0 alpha:kalpha]
// 图片设置宏
#define KKIMAGE(string) [UIImage imageNamed:string]
// 全局默认背景颜色
#define KKGLOBAL KKCOLOR(238, 238, 238, 1.0)
// 全局默认导航栏、tabBar背景颜色
#define KKGLOBARCOLOR KKCOLOR(228, 228, 228, 1.0)
// 全局 导航栏 和 tabBar 渲染颜色
#define KKGLOTINTCOLOR KKCOLOR(80, 120, 150, 1)
// 按钮颜色
#define KKButtonNormalColor KKCOLOR(0, 122, 255, 1)
#define KKButtonDisableColor KKCOLOR(122, 122, 122, 1)
// bounds.size
#define KKSCREENBOUNDSIZE [UIScreen mainScreen].bounds.size
// bounds.size.width 的百分比
#define KKBWIDTHPRECENT(x)  KKSCREENBOUNDSIZE.width * x * 1.0/375
#define KKScreenWidthPrecent(x) KKSCREENBOUNDSIZE.width * x
#define KKScreenHeightPrecent(x) KKSCREENBOUNDSIZE.height * x

// 缓存地址
#define KKCACHEPATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

// 网络缓存地址
#define KKNETWORKCACHESPATH [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"/DP.NETWORK"]



/** apiKey **/

#define KKGDMAPAPIKEY @"19d7dfa2a4734ca4f150e15db60d3dd3"
#define KKUMAPIKEY @"579dfeb7e0f55a2aa7000b56"
#define KKBMOBAPIKEY @"9e266ba3adf895e8b4c40bacb3d461ec"
#define KKSHAREAPIKEY @"155157a41f54c"
#define KKQQAPIID @"100371282"
#define KKQQAPIKEY @"aed9b0303e3ed1e27bae87c33761161d"
#define KKTENAPIKEY @"1105597156"
#define KKWXAPIID @"wx80106443bd33626d"
#define KKWXAPIKEY @"edaaa1793dfc4d8ff6c5561ae09ddd3f"
#define KKSMSAPIKEY @"160fc2f6a7408"
#define KKSMSSCREKEY @"6398e49132e167b0cdc96f22c7a2a4e9"

// 评分地址
#define KKAPPLESTOREADDRESS @"/wei-xin/id414478124"



/** 代码块 **/
// 归档处理对象代码
#define KKFILE     unsigned int outCount; \
Ivar *varList = class_copyIvarList(self.class, &outCount); \
for (int i=0; i<outCount; i++) { \
Ivar ivar = varList[i]; \
const char *name = ivar_getName(ivar); \
NSString *OCName = [NSString stringWithUTF8String:name]; \
id value = [self valueForKey:OCName]; \
[aCoder encodeObject:value forKey:OCName]; \
} \
free(varList);

// 解档处理对象代码
#define KKSOLFILE        unsigned int outCout; \
Ivar *varList = class_copyIvarList(self.class, &outCout); \
for (int i=0; i<outCout; i++) { \
Ivar var = varList[i]; \
const char *cname = ivar_getName(var); \
NSString *sname = [NSString stringWithUTF8String:cname]; \
id value = [aDecoder decodeObjectForKey:sname]; \
[self setValue:value forKey:sname]; \
} \
free(varList);

#define KK_DATA_CURING \
- (void)encodeWithCoder:(NSCoder *)aCoder { \
KKFILE; \
} \
- (id)initWithCoder:(NSCoder *)aDecoder { \
if (self = [super init]) { \
KKSOLFILE; \
} \
return self; \
}


#endif /* Constant_h */




