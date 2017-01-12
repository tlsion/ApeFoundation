//
//  NSArray+Extension.m
//  Youhu
//
//  Created by Eton on 2016/12/3.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (id)objectNoNullAtIndex:(NSUInteger)index{
    if (index < self.count ) {
        return [self objectAtIndex:index];
    }
    return nil;
}

@end

@implementation NSMutableArray (Extension)

- (void)removeObjectNoNull:(id)anObject{
    if ([self containsObject:anObject]) {
        NSInteger index = [self indexOfObject:anObject];
        [self removeObjectAtIndex:index];
    }
}

@end
