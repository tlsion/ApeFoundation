//
//  UITextLimit.h
//  Youhu
//
//  Created by Eton on 2016/10/26.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LIMIT_KEY @"UITextLimit_maxLen"
/**
 *  输入长度限制
 *  方法1：textView.o_maxLen = 10;
 *  方法2：[textView setValue:@(10) forKey:LIMIT_KEY];
 */
@interface UITextField (Limit1)
@property (nonatomic,assign) NSUInteger o_maxLen;//最大长度(0无限制)
@end
@interface UITextView (Limit1)
@property (nonatomic,assign) NSUInteger o_maxLen;//最大长度(0无限制)
@end
