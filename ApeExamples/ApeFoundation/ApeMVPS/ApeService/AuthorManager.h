//
//  AuthorManager.h
//  lantu
//
//  Created by Eric Wang on 15/8/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginResModel.h"
#import "UserAccount.h"

@class FailureResponseModel;

@interface AuthorManager : NSObject

+ (AuthorManager *)shareMgr;

/**
 *  当前是否为登录状态
 *
 *  @return 登录状态
 */
+ (BOOL)isLogin;

/**
 *  获取 ticket 完整字符串
 *
 *  @return ticket 完整字符串
 */
+ (NSString *)ticket;

/**
 *  设置当前登录信息
 *
 *  @param loginRes LoginResModel
 */
+ (void)setLoginInfo:(LoginResModel *)loginRes;

/**
 *  获取当前登录信息
 *
 *  @return LoginResModel
 */
+ (LoginResModel *)loginInfo;

/**
 *  清除用户信息
 */
+ (void)clearLoginUserInfo;


/**
 *  用户账号信息
 */
+ (void)setUserAccount:(UserAccount *)userAccount;

+ (UserAccount *)userAccount;

/**
 *  修改当前用户信息
 *
 *  @param user 用户信息
 */
//+ (void)saveUser:(UserModel *)user;


+ (void)postLoginStatusInvalidNotification:(FailureResponseModel *)failureResponse;

+ (void)addLoginStatusInvalidNotificationUsingBlock:(void (^)(NSNotification *note))block;

+ (void)removeLoginStatusInvalidObserver:(id)observer;

+ (NSTimeInterval)timeIntervalFromLastLogin;

+ (void)saveLoginDate;

@end
