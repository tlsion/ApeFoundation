//
//  AuthorManager.m
//  lantu
//
//  Created by Eric Wang on 15/8/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "AuthorManager.h"
#import "FailureResponseModel.h"

static NSString *const loginResponseModelKey = @"LoginResponseModelKey";

static NSString *const userLoginStatusInvalidKey = @"userLoginStatusInvalidKey";

static NSString *const lastLoginKey = @"lastLoginKey";

static NSString *const userAccountInvalidKey = @"userAccountInvalidKey";

static AuthorManager *__shareMgr = nil;

@interface AuthorManager ()

@end

@implementation AuthorManager

+ (AuthorManager *)shareMgr{
    if (__shareMgr == nil) {
        __shareMgr = [[AuthorManager alloc] init];
        
    }
    
    return __shareMgr;
}

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (BOOL)isLogin{
    if ([self ticket]) {
        return YES;
    }
    return NO;
}

+ (NSString *)ticket{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:loginResponseModelKey];
    LoginResModel *loginRes = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return loginRes.ticket;
}

+ (void)setLoginInfo:(LoginResModel *)loginRes{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *loginResEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:loginRes];
    [defaults setValue:loginResEncodedObject forKey:loginResponseModelKey];
    [defaults synchronize];
}

+ (LoginResModel *)loginInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:loginResponseModelKey];
    LoginResModel *loginRes = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return loginRes;
}

+ (void)clearLoginUserInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:nil forKey:loginResponseModelKey];
    [defaults setValue:nil forKey:userAccountInvalidKey];
    [kNotification postNotificationName:K_SET_TICKET_NOTIFICATION object:nil];
    
    [defaults synchronize];
}

+ (void)setUserAccount:(UserAccount *)userAccount{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:userAccount];
    [defaults setValue:encodedObject forKey:userAccountInvalidKey];
    [defaults synchronize];
}

+ (UserAccount *)userAccount{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:userAccountInvalidKey];
    UserAccount *user = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return user;
}


+ (void)postLoginStatusInvalidNotification:(FailureResponseModel *)failureResponse{
    [AuthorManager clearLoginUserInfo];
    [[GlobalIM shared] logoutIM];
    [[NSNotificationCenter defaultCenter] postNotificationName:userLoginStatusInvalidKey object:nil];
    if (failureResponse) {
        [MBProgressHUD tx_showError:failureResponse.errorMessage];
    }
}

+ (void)addLoginStatusInvalidNotificationUsingBlock:(void (^)(NSNotification *note))block{
    [[NSNotificationCenter defaultCenter] addObserverForName:userLoginStatusInvalidKey object:nil queue:nil usingBlock:block];
    
}

+ (void)removeLoginStatusInvalidObserver:(id)observer{
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:userLoginStatusInvalidKey object:nil];
}


+ (NSTimeInterval)timeIntervalFromLastLogin
{
    NSDate * date = [NSDate date];
    NSDate * lastLoginDate = [[NSUserDefaults standardUserDefaults] objectForKey:lastLoginKey];
    NSTimeInterval betweenTime;
    if (lastLoginDate) {
        betweenTime  = [date timeIntervalSinceDate:lastLoginDate];
    }
    return betweenTime;
}

+ (void)saveLoginDate
{
    NSDate * date = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:lastLoginKey];
    
}
@end
