//
//  NSDictionary+Extension.h
//  Youhu
//
//  Created by Eton on 2016/10/26.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

- (NSString*)dataToJsonString;

//对象 转 字典
+ (NSDictionary*)dictionaryWithObject:(id)obj;

@end
