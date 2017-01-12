//
//  UIView+Extension.h
//  JKPlus
//
//  Created by WJM on 15/10/28.
//  Copyright © 2015年 WJM. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define kSMainScreenHeight [UIScreen mainScreen].bounds.size.height

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat cornerRadius;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign,readonly) CGPoint selfCenter;
@property (nonatomic, assign,readonly) CGFloat selfCenterX;
@property (nonatomic, assign,readonly) CGFloat selfCenterY;

///该View所在的Controller
- (UIViewController *)viewController;

/**
 *  删除所有的子类视图
 */
- (void)removeAllSubViews;
/**
 *  删除视图中特定类别的子类视图
 *
 *  @param cls 制定类别
 */
- (void)removeSubviewsWithSubviewClass:(Class)cls;
/**
 *  删除视图中特定Tag的子类视图
 *
 *  @param tag zilei
 */
- (void)removeSubviewsWithSubviewTag:(NSInteger)tag;
/**
 *  判断该View 是否 在屏幕上
 */
- (BOOL)isDisplayedInScreen;

/**
 *  自动从xib创建视图
 */
+(instancetype)loadFromNIB;
+ (id)loadFromNIBNamed:(NSString *)nibName;
+ (UINib *)loadNib;

@end
