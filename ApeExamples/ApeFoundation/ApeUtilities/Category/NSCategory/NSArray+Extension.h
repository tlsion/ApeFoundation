//
//  NSArray+Extension.h
//  Youhu
//
//  Created by Eton on 2016/12/3.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)

- (id)objectNoNullAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (Extension)

- (void)removeObjectNoNull:(id)anObject;

@end
