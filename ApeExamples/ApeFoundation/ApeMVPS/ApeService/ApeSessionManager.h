//
//  ApeSessionManager
//  Youhu
//
//  Created by Eton on 2016/10/26.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "REMHTTPSessionManager.h"

@interface ApeSessionManager : REMHTTPSessionManager

+ (instancetype)sharedManager;

- (AFJSONRequestSerializer *)apeSerializer;

@end
