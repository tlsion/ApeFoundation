//
//  ApeParam.m
//  Youhu
//
//  Created by Eton on 2016/11/26.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeParam.h"

@implementation ApeParam

- (id)init{
    self = [super init];
    if (self) {
        _page = @(FIRST_PAGE).stringValue;
        _size = @(DEFAULT_PAGE_SIZE).stringValue;
    }
    return self;
}

/**
 *  类的属性 跟  服务端 json keypath 的映射
 *
 *  @return @{@"属性" :@"jsonKeyPath"}
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSSet * setProperty = (NSSet *)[self propertyKeys];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    for (NSString *propertyKey in setProperty) {
        NSString * jsonKey = [NSString stringWithFormat:@"%@",propertyKey];
        [dict setObject:jsonKey forKey:propertyKey];
    };
    return dict;
}

- (NSDictionary *)dictionaryValue {
    NSMutableDictionary *modifiedDictionaryValue = [[super dictionaryValue] mutableCopy];

    for (NSString *originalKey in [super dictionaryValue]) {
        id value = [self valueForKey:originalKey];
        if (value == nil || value == NULL) {
            [modifiedDictionaryValue removeObjectForKey:originalKey];
        }else if ([value isKindOfClass:[MTLModel class]]){
            [modifiedDictionaryValue setValue:[value dictionaryValue] forKey:originalKey];
        }
    }

    return [modifiedDictionaryValue copy];
}

- (void)setNilValueForKey:(NSString *)key {
    [self setValue:@0 forKey:key];  // For NSInteger/CGFloat/BOOL
}



@end
