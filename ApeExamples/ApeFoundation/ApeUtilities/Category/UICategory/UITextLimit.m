//
//  UITextLimit.m
//  Youhu
//
//  Created by Eton on 2016/10/26.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "UITextLimit.h"
#import <objc/runtime.h>

@implementation UITextField (Limit1)
-(id)valueForUndefinedKey:(NSString *)key {
    if ([key isEqualToString:LIMIT_KEY]) {
        return objc_getAssociatedObject(self, key.UTF8String);
    }
    return nil;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:LIMIT_KEY]) {
        objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN);
    }
}
-(void) setO_maxLen:(NSUInteger)o_maxLen
{
    objc_setAssociatedObject(self, @"o_maxLen", @(o_maxLen), OBJC_ASSOCIATION_RETAIN);
}

-(NSUInteger) o_maxLen
{
    NSNumber* max = (NSNumber*)(objc_getAssociatedObject(self, @"o_maxLen"));
    if (!max) {
        return 0;
    }
    return max.unsignedIntegerValue;
}
@end

@implementation UITextView (Limit1)
-(id)valueForUndefinedKey:(NSString *)key {
    if ([key isEqualToString:LIMIT_KEY]) {
        return objc_getAssociatedObject(self, key.UTF8String);
    }
    return nil;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:LIMIT_KEY]) {
        objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN);
    }
}
-(void) setO_maxLen:(NSUInteger)o_maxLen
{
    objc_setAssociatedObject(self, @"o_maxLen", @(o_maxLen), OBJC_ASSOCIATION_RETAIN);
}

-(NSUInteger) o_maxLen
{
    NSNumber* max = (NSNumber*)(objc_getAssociatedObject(self, @"o_maxLen"));
    if (!max) {
        return 0;
    }
    return max.unsignedIntegerValue;
}
@end
