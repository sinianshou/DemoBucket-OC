//
//  IphoneDeviceManagerMacro.h
//  DemoBucket-OC
//
//  Created by Easer on 2017/12/26.
//  Copyright © 2017年 Liu Easer. All rights reserved.
//

#ifndef IphoneDeviceManagerMacro_h
#define IphoneDeviceManagerMacro_h


//考虑转屏的影响，按照实际屏幕方向（UIDeviceOrientation）的宽高

#define EASY_SCREEN_WIDTH_ORI ([UIScreen mainScreen].bounds.size.width)

#define EASY_SCREEN_HEIGHT_ORI ([UIScreen mainScreen].bounds.size.height)

#define EASY_STATUSBAR_HEIGHT_ORI ([UIApplication sharedApplication].statusBarFrame.size.height)

//不考虑转屏的影响，只取竖屏（UIDeviceOrientationPortrait）的宽高

#define EASY_SCREEN_WIDTH_POR MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)

#define EASY_SCREEN_HEIGHT_POR MAX([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)

#define EASY_STATUSBAR_HEIGHT_POR MIN([UIApplication sharedApplication].statusBarFrame.size.width, [UIApplicationshared Application].statusBarFrame.size.height)

// iOS8新增了nativeBounds属性，输出竖屏像素级分辨率：

#define EASY_NATIVEBOUNDS [(UIScreen*)[UIScreen mainScreen] nativeBounds]

//UIScreen.applicationFrame: Frame of application screen area in points (i.e.entire screen minus status bar if visible)
// APPFRAME_WIDTH=SCREEN_WIDTH

#define EASY_APPFRAME_WIDTH ([UIScreen mainScreen].applicationFrame.size.width)

// APPFRAME_HEIGHT=SCREEN_HEIGHT-STATUSBAR_HEIGHT

//注意：横屏（UIDeviceOrientationLandscape）时，iOS8默认隐藏状态栏，此时APPFRAME_HEIGHT=SCREEN_HEIGHT

#define EASY_APPFRAME_HEIGHT ([UIScreen mainScreen].applicationFrame.size.height)


#endif /* IphoneDeviceManagerMacro_h */
