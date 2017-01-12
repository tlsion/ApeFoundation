//
//  NSString+Calculate.h
//  Youhu
//
//  Created by Eton on 2016/12/13.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Calculate)

/**
 *  计算字体大小
 */
- (CGSize) textSizeWithFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat )estimateTextHeightByTextFont:(UIFont *)font width:(CGFloat)width;

- (CGFloat )estimateTextWidthByTextFont:(UIFont *)font;

- (CGSize )estimateTextSizeByTextFont:(UIFont *)font size:(CGSize )size;


@end
