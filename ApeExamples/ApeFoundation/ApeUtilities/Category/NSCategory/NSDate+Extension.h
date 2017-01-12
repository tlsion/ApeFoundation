//
//  NSDate+Extension.h
//  ShopManagement
//
//  Created by 易 德强 on 15/4/16.
//  Copyright (c) 2015年 FUNO. All rights reserved.
//

#pragma mark -

#define SECOND	(1)
#define MINUTE	(60 * SECOND)
#define HOUR	(60 * MINUTE)
#define DAY		(24 * HOUR)
#define MONTH	(30 * DAY)
#define YEAR	(12 * MONTH)

#pragma mark -

@interface NSDate(Extension)

@property (nonatomic, readonly) NSInteger	year;
@property (nonatomic, readonly) NSInteger	month;
@property (nonatomic, readonly) NSInteger	day;
@property (nonatomic, readonly) NSInteger	hour;
@property (nonatomic, readonly) NSInteger	minute;
@property (nonatomic, readonly) NSInteger	second;
@property (nonatomic, readonly) NSInteger	weekday;

- (NSString *)stringYD;//yyyy-MM-dd
- (NSString *)stringYM;//yyyy-MM-dd HH:mm
- (NSString *)stringYS;//yyyy-MM-dd HH:mm:ss
- (NSString *)stringWithDateFormat:(NSString *)format;
- (NSString *)timeAgo;//刚刚、1分钟前、昨天、1个月前....
- (NSString *)timeLeft;//*年、*月、*天、*小时、*分钟、*秒

+ (NSString *)nowYS;
+ (NSTimeInterval)timeStamp;//timeIntervalSince1970
+ (NSDate *)dateFromString:(NSString *)dateString andDateWithFormat:(NSString *)format;
+ (NSDate *)dateWithString:(NSString *)string;
+ (NSDate *)now;




@end
