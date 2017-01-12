//
//  ApeSessionManager.m
//  Youhu
//
//  Created by Eton on 2016/10/26.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeSessionManager.h"
#import <REMResponseSerializer.h>

@implementation ApeSessionManager

+ (instancetype)sharedManager{
    static ApeSessionManager * _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[ApeSessionManager alloc] initWithBaseURL:APPHostURL.URL];
        
    });
//    [_sharedManager.requestSerializer setValue:[[BaseDataMgr shareBaseDataMgr] googleAuthCode] forHTTPHeaderField:@"validcode"];
    
    return _sharedManager;
}


- (instancetype)initWithBaseURL:(NSURL *)URL
{
    self = [super initWithBaseURL:URL sessionConfiguration:nil];
    if (self) {
        
        [self setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]];
        [self setRequestSerializer:[self apeSerializer]];
        REMCompoundResponseSerializer * response = [self responseSerializer];
        
        response.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html", nil];
        
        [kNotification addObserver:self selector:@selector(setTicket:) name:K_SET_TICKET_NOTIFICATION object:nil];
    }
    return self;
}

- (AFJSONRequestSerializer *)apeSerializer{
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:APIVersion forHTTPHeaderField:@"api_version"];
    [requestSerializer setValue:AppSite forHTTPHeaderField:@"site"];
    [requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"ios" forHTTPHeaderField:@"os"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    return requestSerializer;
}



- (void)setTicket:(NSNotification *)notification{
    NSString * ticket = notification.object;
    
    [self.requestSerializer setValue:ticket forHTTPHeaderField:@"ticket"];
    [self.requestSerializer setValue:[ticket isNotNull]?@"false":@"true" forHTTPHeaderField:@"tourist"];
    
}


@end
