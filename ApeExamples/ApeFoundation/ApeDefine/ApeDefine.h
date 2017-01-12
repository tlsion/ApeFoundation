//
//  ApeDefine.h
//  Youhu
//
//  Created by Eton on 2016/10/26.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#ifndef ApeDefine_h
#define ApeDefine_h

//版本
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//判断版本
#define IS_EQUAL_IOS(v) (SYSTEM_VERSION == v)//等于此版本
#define IS_GREATER_IOS(v) (SYSTEM_VERSION > v)//高于此版本
#define IS_LESS_IOS(v) (SYSTEM_VERSION < v)//低于此版本
#define IS_GREATER_EQUAL_IOS(v) (SYSTEM_VERSION >= v)//高于等于此版本
#define IS_LESS_EQUAL_IOS(v) (SYSTEM_VERSION <= v)//低于等于此版本

//屏幕宽高
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define NAV_BAR_HEIGHT 66.0f
#define TAB_BAR_HEIGHT 49.0f
#define VIEW_HEIGHT (SCREEN_HEIGHT - NAV_BAR_HEIGHT)

//相对于 750 宽的屏幕比例
#define SCREEN_SCALE_47 (SCREEN_WIDTH/375.0f)

//判断 屏幕尺寸
#define IS_SCREEN_55_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_47_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//Color便利构造宏
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGBS(v) [UIColor colorWithRed:(v)/255.0f green:(v)/255.0f blue:(v)/255.0f alpha:1]

#define HEXA(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]
#define HEX(hexValue)   HEXA(hexValue,1.0)

//主、子线程
#define kMainQueue dispatch_get_main_queue() //主线程队列
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //全局并发队列

//格式化 字符串
#define FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]

//便利 UserDefaults
#define  kUserDefaults [NSUserDefaults standardUserDefaults]

//便利化 AppDelegate
#define  kAppDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)

//便利化定义 Weak Self
#define kWeakSelf __weak __typeof(self) weakSelf = self

//便利化 通知
#define kNotification [NSNotificationCenter defaultCenter]
#define kNotificationPost(name) [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil]

//控制打印
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#endif /* ApeDefine_h */
