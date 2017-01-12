//
//  UILabel+VerticalAlignment.m
//  Pocket91
//
//  Created by yi_dq on 22/9/13.
//  Copyright (c) 2013 Bodong Baidu. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (void)alignmentTop {
    CGSize fontSize = [self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++) {
        self.text = [self.text stringByAppendingString:@"\n "];
    }
}

- (void)alignmentBottom {
    CGSize fontSize = [self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++) {
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
    }
}



- (CGFloat )estimateWidth{
    CGFloat width = [self.text estimateTextWidthByTextFont:self.font];
    return ceil(width);
}

- (CGFloat )estimateHeightByWidth:(CGFloat )width{
    CGFloat height = [self.text estimateTextHeightByTextFont:self.font width:self.width];
    return ceil(height);
}


@end
