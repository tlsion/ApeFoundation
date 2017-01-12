//
//  ApplicationInfo.h
//  Youhu
//
//  Created by Pro on 2016/12/6.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationInfo : NSObject

/**
 * 获取App显示名称
 */
+ (NSString *)appDisplayName;

/**
 * 获取App主版本号(1.0.0)
 */
+ (NSString *)appMajorVersion;

/**
 * 获取App次版本号 (2017011001)
 */
+ (NSString *)appMinorVersion;

/**
 * 获取AppID (com.apestar.demo)
 */
+ (NSString *)appBundleID;

@end
