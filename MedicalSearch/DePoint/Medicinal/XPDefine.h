//
//  XPDefine.h
//  DePoint
//
//  Created by apple on 16/8/6.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#ifndef XPDefine_h
#define XPDefine_h

#define KWidth  self.view.frame.size.width
#define WHeigth  self.view.frame.size.height



#define kDurgPath @"http://www.tngou.net/api/drug/classify"//药品分类
#define KNexinePath @"http://www.tngou.net/api/drug/classify?id=%ld"//药品分类第二层
#define KListPath @"http://www.tngou.net/api/drug/list?id=%ld&page=%ld"//药品列表
#define KDetailPath @"http://www.tngou.net/api/drug/show?id=%ld"//药品详情
#define kNamePath @"http://www.tngou.net/api/drug/name?name=%@"//搜索药名
#endif /* XPDefine_h */
