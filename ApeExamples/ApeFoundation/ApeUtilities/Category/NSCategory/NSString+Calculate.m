//
//  NSString+Calculate.m
//  Youhu
//
//  Created by Eton on 2016/12/13.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "NSString+Calculate.h"

@implementation NSString (Calculate)

#pragma mark- 文字所占宽高计算
/**
 *  计算字体大小
 */
- (CGSize) textSizeWithFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode
{
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    
    //上取整，避免小数位误差
    result.width = ceil(result.width);
    result.height = ceil(result.height);
    
    return result;
}

- (CGFloat )estimateTextHeightByTextFont:(UIFont *)font width:(CGFloat)width
{
    if (self.length <= 0)
        return 0.0f;
    CGSize size = [self textSizeWithFont:font size:CGSizeMake(width, MAXFLOAT) mode:NSLineBreakByCharWrapping];
    return ceil(size.height);
}

- (CGFloat )estimateTextWidthByTextFont:(UIFont *)font
{
    if (self.length <= 0)
        return 0.0f;
    CGSize size = [self textSizeWithFont:font size:CGSizeMake(MAXFLOAT,0) mode:NSLineBreakByCharWrapping];
    return ceil(size.width);
}

- (CGSize )estimateTextSizeByTextFont:(UIFont *)font size:(CGSize )size
{
    CGSize theSize = CGSizeZero;
    if (self.length <= 0)
        return theSize;
    theSize = [self textSizeWithFont:font size:size mode:NSLineBreakByCharWrapping];
    return theSize;
    
}

@end
