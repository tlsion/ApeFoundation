//
//  UIButton+Extension.m
//  Youhu
//
//  Created by Eton on 2016/10/27.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

/**
 * 设置圆角
 */
-(void) setCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.clipsToBounds = YES;
    
}


/**
 * 设置边框 宽度 和 颜色
 */
-(void) setBorderWidth:(CGFloat)width color:(UIColor*)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}


/**
 * 用颜色来设置 背景色状态。
 */
-(void) setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    UIImage* sourceImage = [UIImage imageWithColor:backgroundColor];
    sourceImage = [sourceImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self setBackgroundImage:sourceImage forState:state];
}

@end
