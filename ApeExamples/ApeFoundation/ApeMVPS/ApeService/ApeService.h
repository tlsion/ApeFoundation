//
//  ApeService.h
//  ApeExamples
//
//  Created by Eton on 2017/1/7.
//  Copyright © 2017年 Tlsion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FailureResponseModel.h"

#define FIRST_PAGE 1
#define DEFAULT_PAGE_SIZE 10

@class FailureResponseModel;

typedef void(^CommonSuccessResponse)(NSURLSessionDataTask *dataTask, id response);
typedef void(^CommonArrayResponse)(NSURLSessionDataTask *dataTask, NSArray *arrayResponse);
typedef void(^CommonErrorResponse)(NSURLSessionDataTask *dataTask, FailureResponseModel *failureResponse);

@interface ApeService : NSObject

/**
 *  @param URLString  The URL string used to create the request URL.
 *  @param parameters The parameters to be encoded according to the client request serializer.
 *  @param modelClass Your MTLModel subclass that also conforms to MTLJSONSerializing. Can be NIL but if so will only return a JSON Dictionary for the given keyPath.
 *  @param keyPath    The root keyPath of the model object.  Can be nil.
 *  @param success    A block object to be executed when the task finishes successfully. This block has no return value and takes two arguments: the data task, and the response object created by the client response serializer.
 *  @param failure    A block object to be executed when the task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a two arguments: the data task and the error describing the network or parsing error that occurred.
 
 *
 *  @return The created and resumed NSURLSessionDataTask
 */

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `GET` request.
*/
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                   modelClass:(Class)modelClass
                      keyPath:(NSString *)keyPath
                      success:(CommonSuccessResponse)success
                      failure:(CommonErrorResponse)failure;

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `POST` request.
 */
+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                    modelClass:(Class)modelClass
                       keyPath:(NSString *)keyPath
                       success:(CommonSuccessResponse)success
                       failure:(CommonErrorResponse)failure;

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `DELETE` request.
 */
+ (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                      modelClass:(Class)modelClass
                         keyPath:(NSString *)keyPath
                         success:(CommonSuccessResponse)success
                         failure:(CommonErrorResponse)failure;
/**
 *  Creates and runs an `NSURLSessionDataTask` with a `PUT` request.
 */
+ (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                   modelClass:(Class)modelClass
                      keyPath:(NSString *)keyPath
                      success:(CommonSuccessResponse)success
                      failure:(CommonErrorResponse)failure;


/**
 *  Creates and runs an `NSURLSessionDataTask` with a `GET` request.
 *  @param sessionManager Custom ApeSessionManager
 */

+ (NSURLSessionDataTask *)ApeSessionManager:(ApeSessionManager *)sessionManager GET:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                 modelClass:(Class)modelClass
                                    keyPath:(NSString *)keyPath
                                    success:(CommonSuccessResponse)success
                                    failure:(CommonErrorResponse)failure;

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `POST` request.
 *  @param sessionManager Custom ApeSessionManager
 */
+ (NSURLSessionDataTask *)ApeSessionManager:(ApeSessionManager *)sessionManager POST:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                 modelClass:(Class)modelClass
                                    keyPath:(NSString *)keyPath
                                    success:(CommonSuccessResponse)success
                                    failure:(CommonErrorResponse)failure;

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `DELETE` request.
 *  @param sessionManager Custom ApeSessionManager
 */
+ (NSURLSessionDataTask *)ApeSessionManager:(ApeSessionManager *)sessionManager DELETE:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                 modelClass:(Class)modelClass
                                    keyPath:(NSString *)keyPath
                                    success:(CommonSuccessResponse)success
                                    failure:(CommonErrorResponse)failure;

/**
 *  Creates and runs an `NSURLSessionDataTask` with a `PUT` request.
 *  @param sessionManager Custom ApeSessionManager
 */
+ (NSURLSessionDataTask *)ApeSessionManager:(ApeSessionManager *)sessionManager PUT:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                 modelClass:(Class)modelClass
                                    keyPath:(NSString *)keyPath
                                    success:(CommonSuccessResponse)success
                                    failure:(CommonErrorResponse)failure;

@end
