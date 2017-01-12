//
//  NSDictionary+Extension.m
//  Youhu
//
//  Created by Eton on 2016/10/26.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "NSDictionary+Extension.h"
#import <objc/runtime.h>

@implementation NSDictionary (Extension)

- (NSString*)dataToJsonString{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (NSDictionary*)dictionaryWithObject:(NSObject *)obj {

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    
    for(int i = 0;i < propsCount; i++) {
        
        objc_property_t prop = props[i];
        @try {
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)] ;
            propName = [self filterSpecialPropName:propName];
            id value = [obj valueForKey:propName];
            if(value) {
                value = [self objectWithInternal:value];
                [dic setValue:value forKey:propName];
            }
        }
        @catch (NSException *exception) {
            //[self logError:exception];
            NSLog(@"%@",exception);
        }
    }
    
    free(props);
    
    return dic;
}

+ (id)objectWithInternal:(id)obj {
    
    if([obj isKindOfClass:[NSString class]]
       ||
       [obj isKindOfClass:[NSNumber class]]
       ||
       [obj isKindOfClass:[NSNull class]]) {
        
        return obj;
        
    }
    if([obj isKindOfClass:[NSArray class]]) {
        
        NSArray *objarr = obj;
        if (objarr.count == 0) {
            return nil;
        }
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        
        for(int i = 0; i < objarr.count; i++) {
            
            [arr setObject:[self objectWithInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *objdic = obj;
        if (objdic.allKeys.count == 0) {
            return nil;
        }
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        
        for(NSString *key in objdic.allKeys) {
            
            [dic setObject:[self objectWithInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    if([obj isKindOfClass:[NSObject class]]) {
        return [self dictionaryWithObject:obj];
    }
    return nil;
    
}


//项目逻辑需要
+ (NSString *)filterSpecialPropName:(NSString *)propName{
    if ([propName isEqualToString:@"_id"]) {
        return @"id";
    }else if ([propName isEqualToString:@"identifier"]) {
        return @"id";
    }else if ([propName isEqualToString:@"_description"]) {
        return @"description";
    }
    return propName;
}

@end
