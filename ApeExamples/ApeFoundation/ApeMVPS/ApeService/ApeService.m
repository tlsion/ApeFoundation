//
//  ApeService.m
//  ApeExamples
//
//  Created by Eton on 2017/1/7.
//  Copyright © 2017年 Tlsion. All rights reserved.
//

#import "ApeService.h"
#import "ApeSessionManager.h"
/**
 *  错误代码
 */
typedef NS_ENUM(NSInteger, ResponseCodeType){
    /**
     *  成功
     */
    ResponseCodeTypeSuccess = 200,
    
    /**
     *  登录已经失效
     */
    ResponseCodeTypeLoginInvalid = 401,
    /**
     *  令牌失效
     */
    ResponseCodeTypeTokenInvalid = 406,
    /**
     *  账号从其他设备登录
     */
    ResponseCodeTypeLoginInOtherDevice = 410,
    
    /**
     *  服务器出错了
     */
    ResponseCodeTypeServiceError = 500
};

#define kErrorCdoeResponseKey @"error_code"
#define kErrorMessageKey @"message"

@implementation ApeService<UIAlertViewDelegate>

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                   modelClass:(Class)modelClass
                      keyPath:(NSString *)keyPath
                      success:(CommonSuccessResponse)success
                      failure:(CommonErrorResponse)failure{
    return [[ApeSessionManager sharedManager] GET:URLString
                                       parameters:parameters
                                         progress:nil
                                       modelClass:modelClass
                                          keyPath:keyPath
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                              
                                              if (success) {
                                                  success(task, responseObject);
                                              }
                                          }
                                          failure:^(NSURLSessionDataTask *task, NSError *error) {
                                              
                                              FailureResponseModel * failureResponse = [ApeService requestFailure:error ];
                                              if (failure) {
                                                  failure(task, failureResponse);
                                              }
                                              
                                          }];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                    modelClass:(Class)modelClass
                       keyPath:(NSString *)keyPath
                       success:(CommonSuccessResponse)success
                       failure:(CommonErrorResponse)failure{
    return [[ApeSessionManager sharedManager] POST:URLString
                                        parameters:parameters
                                          progress:nil
                                        modelClass:modelClass
                                           keyPath:keyPath
                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                               if (success) {
                                                   success(task, responseObject);
                                               }
                                           }
                                           failure:^(NSURLSessionDataTask *task, NSError *error) {
                                               FailureResponseModel * failureResponse = [ApeService requestFailure:error ];
                                               if (failure) {
                                                   failure(task, failureResponse);
                                               }
                                               
                                           }];
}

+ (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                      modelClass:(Class)modelClass
                         keyPath:(NSString *)keyPath
                         success:(CommonSuccessResponse)success
                         failure:(CommonErrorResponse)failure{
    return [[ApeSessionManager sharedManager] DELETE:URLString
                                          parameters:parameters
                                          modelClass:modelClass
                                             keyPath:keyPath
                                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                 
                                                 if (success) {
                                                     success(task, responseObject);
                                                 }
                                             }
                                             failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                 
                                                 FailureResponseModel * failureResponse = [ApeService requestFailure:error ];
                                                 if (failure) {
                                                     failure(task, failureResponse);
                                                 }
                                             }];
}

+ (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                   modelClass:(Class)modelClass
                      keyPath:(NSString *)keyPath
                      success:(CommonSuccessResponse)success
                      failure:(CommonErrorResponse)failure{
    return [[ApeSessionManager sharedManager] PUT:URLString
                                       parameters:parameters
                                       modelClass:modelClass
                                          keyPath:keyPath
                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                              
                                              if (success) {
                                                  success(task, responseObject);
                                              }
                                          }
                                          failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                              
                                              FailureResponseModel * failureResponse = [ApeService requestFailure:error ];
                                              if (failure) {
                                                  failure(task, failureResponse);
                                              }
                                          }];
}




+ (NSURLSessionDataTask *)ApeSessionManager:(ApeSessionManager *)sessionManager GET:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                 modelClass:(Class)modelClass
                                    keyPath:(NSString *)keyPath
                                    success:(CommonSuccessResponse)success
                                    failure:(CommonErrorResponse)failure{
    
    return [sessionManager GET:URLString
                    parameters:parameters
                      progress:nil
                    modelClass:modelClass
                       keyPath:keyPath
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           
                           if (success) {
                               success(task, responseObject);
                           }
                       }
                       failure:^(NSURLSessionDataTask *task, NSError *error) {
                           
                           FailureResponseModel * failureResponse = [ApeService requestFailure:error ];
                           if (failure) {
                               failure(task, failureResponse);
                           }
                           
                       }];
    
}

+ (NSURLSessionDataTask *)ApeSessionManager:(ApeSessionManager *)sessionManager POST:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                 modelClass:(Class)modelClass
                                    keyPath:(NSString *)keyPath
                                    success:(CommonSuccessResponse)success
                                    failure:(CommonErrorResponse)failure{
    
    return [sessionManager POST:URLString
                     parameters:parameters
                       progress:nil
                     modelClass:modelClass
                        keyPath:keyPath
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            if (success) {
                                success(task, responseObject);
                            }
                        }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            FailureResponseModel * failureResponse = [ApeService requestFailure:error ];
                            if (failure) {
                                failure(task, failureResponse);
                            }
                            
                        }];
}

+ (NSURLSessionDataTask *)ApeSessionManager:(ApeSessionManager *)sessionManager DELETE:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                 modelClass:(Class)modelClass
                                    keyPath:(NSString *)keyPath
                                    success:(CommonSuccessResponse)success
                                    failure:(CommonErrorResponse)failure{
    
    return [sessionManager DELETE:URLString
                       parameters:parameters
                       modelClass:modelClass
                          keyPath:keyPath
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              
                              if (success) {
                                  success(task, responseObject);
                              }
                          }
                          failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                              
                              FailureResponseModel * failureResponse = [ApeService requestFailure:error ];
                              if (failure) {
                                  failure(task, failureResponse);
                              }
                          }];
}


+ (NSURLSessionDataTask *)ApeSessionManager:(ApeSessionManager *)sessionManager PUT:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                 modelClass:(Class)modelClass
                                    keyPath:(NSString *)keyPath
                                    success:(CommonSuccessResponse)success
                                    failure:(CommonErrorResponse)failure{
    
    return [sessionManager DELETE:URLString
                       parameters:parameters
                       modelClass:modelClass
                          keyPath:keyPath
                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              
                              if (success) {
                                  success(task, responseObject);
                              }
                          }
                          failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                              
                              FailureResponseModel * failureResponse = [ApeService requestFailure:error ];
                              if (failure) {
                                  failure(task, failureResponse);
                              }
                          }];
}


+ (FailureResponseModel *)requestFailure:(NSError * _Nonnull) error{
    
    FailureResponseModel *failureResponse;
    NSInteger statusCode = [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
    
    
    NSData *errorData = (NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    
    if (errorData) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
        NSInteger errorcCode = [[json objectForKey:kErrorCdoeResponseKey] integerValue];
        NSString *message = [json objectForKey:kErrorMessageKey];
        
        if (statusCode == ResponseCodeTypeLoginInvalid){
            failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:message];
            [AuthorManager postLoginStatusInvalidNotification:failureResponse];
        }
        else if (statusCode == ResponseCodeTypeLoginInOtherDevice) {
            [ApeService showLoginFromOtherDeviceAlertWithMessage:message];
        }
        else if (statusCode == ResponseCodeTypeTokenInvalid) {
            //            failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:message];
            //            NSNumber *  sDateNum = json[@"data"];
            //            [BaseDataMgr shareBaseDataMgr].serviceDate = [NSDate dateWithTimeIntervalSince1970:[sDateNum doubleValue] / 1000];
        }
        else{
            failureResponse = [[FailureResponseModel alloc] initWithErrorCode:errorcCode errorMessage:message];
        }
    }
    else{
        failureResponse = [[FailureResponseModel alloc] initWithErrorCode:error.code errorMessage:error.userInfo[NSLocalizedDescriptionKey]];
        if (error.code == NSURLErrorNotConnectedToInternet) {
            failureResponse.errorMessage = @"当前网络不可用，请检查您的网络连接";
        }
    }
    return failureResponse;
}

+ (void)showLoginFromOtherDeviceAlertWithMessage:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [AuthorManager postLoginStatusInvalidNotification:nil];
}

@end
