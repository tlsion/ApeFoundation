//
//  UIButton+Extension.h
//  Youhu
//
//  Created by Eton on 2016/10/27.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 * 设置圆角
 */
-(void) setCornerRadius:(CGFloat)radius;

/**
 * 设置边框 宽度 和 颜色
 */
-(void) setBorderWidth:(CGFloat)width color:(UIColor*)color;

/**
 * 用颜色来设置 背景色状态。
 */
-(void) setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
