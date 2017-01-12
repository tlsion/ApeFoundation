//
//  FailureResponseModel.h
//  lantu
//
//  Created by Eric Wang on 15/7/9.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "ApeModel.h"

@interface FailureResponseModel : NSError

@property (assign, nonatomic) NSInteger errorCode;
@property (strong, nonatomic) NSString *errorMessage;

- (id)initWithErrorCode:(NSInteger)errorCode errorMessage:(NSString *)message;

@end
