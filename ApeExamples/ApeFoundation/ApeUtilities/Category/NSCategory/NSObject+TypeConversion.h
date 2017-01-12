//
//  NSData+TypeConversion.h
//  ShopManagement
//
//  Created by 易 德强 on 15/4/16.
//  Copyright (c) 2015年 FUNO. All rights reserved.
//


#pragma mark -

@interface NSObject(TypeConversion)

- (NSInteger)asInteger;
- (float)asFloat;
- (BOOL)asBool;

- (NSNumber *)asNSNumber;
- (NSString *)asNSString;
- (NSDate *)asNSDate;
- (NSData *)asNSData;
- (NSArray *)asNSArray;
- (NSMutableArray *)asNSMutableArray;
- (NSDictionary *)asNSDictionary;
- (NSMutableDictionary *)asNSMutableDictionary;

@end
