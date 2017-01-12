//
//  CheckUpdateMgr.h
//  MakeMoney
//
//  Created by Eric Wang on 16/8/20.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckUpdateMgr : NSObject


+ (void)checkNewVersion:(void(^)(BOOL hasNewVersion, NSString *downloadURL))success
                               errorBlock:(void(^)(FailureResponseModel *errorRes))errorBlock;

@end
