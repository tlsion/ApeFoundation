//
//  UILabel+VerticalAlignment.h
//  Pocket91
//
//  Created by yi_dq on 22/9/13.
//  Copyright (c) 2013 Bodong Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

- (void)alignmentTop;
- (void)alignmentBottom;

- (CGFloat )estimateWidth;
- (CGFloat )estimateHeightByWidth:(CGFloat )width;

@end
