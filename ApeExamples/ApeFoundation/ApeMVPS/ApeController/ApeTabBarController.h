//
//  ApeTabBarController.h
//  Youhu
//
//  Created by Eton on 2016/10/25.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApeTabBarController : UITabBarController<UINavigationControllerDelegate,UITabBarControllerDelegate>

/**
 *  通过index获取tab的控制器
 */
- (UIViewController *)viewControllerInTabWithIndex:(NSInteger )index;

/**
 *  通过class获取tab的控制器
 */
- (UIViewController *)viewControllerInTabWithClass:(Class )vClass;

/**
 *  通过class定位tab的控制器
 */
- (void)selectedViewControllerInTabBarWithClass:(Class )vClass;

/**
 *  当前显示的控制器
 */
- (UIViewController *)currentShowViewController;

- (id )setupViewController:(Class )cls;

- (ApeNavigationController *)setupNavViewController:(UIViewController *)viewController;

@end
