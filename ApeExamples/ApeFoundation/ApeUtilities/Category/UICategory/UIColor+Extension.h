//
//  UIColor+Extension.h
//  WeeFresh
//
//  Created by zhangming on 14-12-8.
//  Copyright (c) 2014年 zhangming. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIColor (Extension)

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor *)colorWithHex:(NSString *)string;

@end
