//
//  KKCustomVCConstants.h
//  DeliveryPoint
//
//  Created by kaki on 16/7/12.
//  Copyright © 2016年 liudhkk. All rights reserved.
//

#ifndef KKCustomVCConstants_h
#define KKCustomVCConstants_h

//App显示的区域
#define MAINSCREEN   [UIScreen mainScreen].applicationFrame
//屏幕的全部区域
#define MAINBOUNDS   [UIScreen mainScreen].bounds



#define SCREEN_WIDTH        ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT       ([[UIScreen mainScreen] bounds].size.height)


#define NavBar_Title_Width                  SCREEN_WIDTH - 130.0f            //标题宽度
#define NavBar_Title_Height                 40.0f             //标题高度

#define NavBar_BarButton_Width              64.0f             //按钮宽度
#define NavBar_BarButton_Height             40.0f             //按钮高度

#define NavBar_BarButton_Right_Width        -6.0f

#define Bottom_H                            49.0f             //底部Tabbar的高度
#define NaviBar_H                           44.0f                                                           //导航栏高度
#define StatusBar_H  [UIApplication sharedApplication].statusBarFrame.size.height    //状态栏的高度


#endif /* KKCustomVCConstants_h */
