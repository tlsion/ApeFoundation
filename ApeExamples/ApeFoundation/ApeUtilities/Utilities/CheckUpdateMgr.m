//
//  CheckUpdateMgr.m
//  MakeMoney
//
//  Created by Eric Wang on 16/8/20.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import "CheckUpdateMgr.h"
#import "ApplicationInfo.h"

@implementation CheckUpdateMgr

+ (void)checkNewVersion:(void(^)(BOOL hasNewVersion, NSString *downloadURL))success
             errorBlock:(void(^)(FailureResponseModel *errorRes))errorBlock{
    NSString* appID = [ApplicationInfo appBundleID];
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", appID]]];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            BOOL hasNewVersion = NO;
            if ([lookup[@"resultCount"] integerValue] == 1){
                
                NSDictionary *result = lookup[@"results"][0];
                
                NSString *appStoreVersion = result[@"version"];
                appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
                appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"V" withString:@""];
                NSInteger appStoreVersionInt = [appStoreVersion integerValue];
                
//                NSString *descriptionString = result[@"releaseNotes"];
                
                NSString *urlString = result[@"trackViewUrl"];
                
                NSString *currentVersion =  [ApplicationInfo appMajorVersion];
                
                currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
                currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"V" withString:@""];
                NSInteger currentVersionInt = [currentVersion integerValue];
                if (currentVersionInt < appStoreVersionInt){
                    hasNewVersion = YES;
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(hasNewVersion, urlString);
                });
            }
        }
        else{
            FailureResponseModel *errorResinfo = [FailureResponseModel new];
            errorResinfo.errorMessage = error.description;
            errorResinfo.errorCode = error.code;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                errorBlock(errorResinfo);
            });
        }
    }];
    [task resume];
}

@end
