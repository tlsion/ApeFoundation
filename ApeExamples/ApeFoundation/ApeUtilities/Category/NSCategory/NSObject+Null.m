//
//  NSObject+Null.m
//  ShopManagement
//
//  Created by Eton on 15/10/9.
//  Copyright © 2015年 FUNO. All rights reserved.
//

#import "NSObject+Null.h"

@implementation NSObject (Null)

- (BOOL)isNotNull
{
    if ([self isEqual:[NSNull null]]) {
        return NO;
    }
    else if ([self isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    else if (self==nil){
        return NO;
    }
    else {
        if ([self isKindOfClass:[NSString class]]) {
            NSString *str = (NSString *)self;
            if ([str isEqualToString:@""]) {
                return NO;
            }
            return YES;
        }
        else if([self isKindOfClass:[NSArray class]]){
            NSArray *arr = (NSArray *)self;
            if (![arr count]) {
                return NO;
            }
            return YES;
        }
        else if([self isKindOfClass:[NSDictionary class]]){
            NSDictionary *dic = (NSDictionary *)self;
            if (![dic count]) {
                return NO;
            }
        }else if([self isKindOfClass:[NSNumber class]]){
            NSNumber *num = (NSNumber *)self;
            if (num.doubleValue == 0) {
                return NO;
            }
        }
        return YES;
    }
    return YES;
}

@end
