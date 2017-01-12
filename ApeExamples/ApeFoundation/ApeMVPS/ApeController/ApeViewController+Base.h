//
//  ApeViewController+Base.h
//  Youhu
//
//  Created by Eton on 2016/11/4.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeViewController.h"

@interface ApeViewController (Base)

/**
 * 设置TabBarItem图片
 */
- (void)setTabBarItemTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;

/**
 * 添加NavigationBar右侧按钮
 */
- (UIButton *)addRightBarText:(NSString *)text image:(UIImage *)image action:(SEL)action;

/**
 * 添加NavigationBar左侧按钮
 */
- (UIButton *)addLeftBarText:(NSString *)text image:(UIImage *)image action:(SEL)action;

/**
 * 创建返回按钮
 */
- (void)crateBackButton;

/**
 * 返回
 */
- (void)back;

/**
 * 返回到指定界面
 */
- (UIViewController *)popToViewControllerClass:(Class)controllerClass;

@end
