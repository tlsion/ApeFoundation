//
//  ApplicationInfo.m
//  Youhu
//
//  Created by Pro on 2016/12/6.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApplicationInfo.h"

@implementation ApplicationInfo

/**
 * 获取App显示名称
 */
+ (NSString *)appDisplayName
{
    //app应用相关信息的获取
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *strAppName = [dicInfo objectForKey:@"CFBundleDisplayName"];
    return strAppName;
}

/**
 * 获取App主版本号
 */
+ (NSString *)appMajorVersion
{
    //app应用相关信息的获取
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *strAppBuild = [dicInfo objectForKey:@"CFBundleShortVersionString"];
    return strAppBuild;
}

/**
 * 获取App次版本号
 */
+ (NSString *)appMinorVersion
{
    //app应用相关信息的获取
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleVersion"];
    return strAppVersion;
}

/**
 * 获取AppID (com.apestar.demo)
 */
+ (NSString *)appBundleID
{
    //app应用相关信息的获取
    NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *strAppVersion = [dicInfo objectForKey:@"CFBundleIdentifier"];
    return strAppVersion;
}

@end
