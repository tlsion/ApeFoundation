//
//  ApeViewController+Base.m
//  Youhu
//
//  Created by Eton on 2016/11/4.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeViewController+Base.h"
#define Nav_Bar_Item_Font 15.0f

@implementation ApeViewController (Base)
/**
 * 设置TabBarItem图片
 */
- (void)setTabBarItemTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    UITabBarItem * tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imageName] selectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.tabBarItem = tabBarItem;
    //    self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
}

/**
 * 添加NavigationBar右侧按钮
 */
- (UIButton *)addRightBarText:(NSString *)text image:(UIImage *)image action:(SEL)action{
    
    UIButton * itemButton = [self navItemButtonWith:text image:image];
    [itemButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
    item.style = UIBarButtonItemStyleDone;
    
    NSMutableArray *rightItems = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    //第一个按钮 按钮的靠右间距问题
    if (!rightItems.count)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        
        [rightItems addObject:negativeSeperator];
    }
    
    [rightItems addObject:item];
    
    self.navigationItem.rightBarButtonItems = rightItems;
    
    return itemButton;
}

/**
 * 添加NavigationBar左侧按钮
 */
- (UIButton *)addLeftBarText:(NSString *)text image:(UIImage *)image action:(SEL)action{
    
    UIButton * itemButton = [self navItemButtonWith:text image:image];
    [itemButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:itemButton];
    item.style = UIBarButtonItemStyleDone;
    
    NSMutableArray *leftItems = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    //第一个按钮 按钮的靠右间距问题
    if (!leftItems.count)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        
        [leftItems addObject:negativeSeperator];
    }
    
    [leftItems addObject:item];
    self.navigationItem.leftBarButtonItems = leftItems;
    
    return itemButton;
    
}

/**
 * 创建返回按钮
 */
- (void)crateBackButton{
    self.navigationItem.leftBarButtonItems = nil;
    UIButton * backButton = [self addLeftBarText:@"" image:[UIImage imageNamed:@"top_left"] action:@selector(back)];
    backButton.width = 25;
}

/**
 * 返回
 */
- (void)back{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 * 返回到指定界面
 */
- (UIViewController *)popToViewControllerClass:(Class)controllerClass{
    NSArray * viewControllers = self.navigationController.viewControllers;
    
    for (UIViewController * controller in viewControllers) {
        
        if ([controller isKindOfClass:controllerClass]) {
            [self.navigationController popToViewController:controller animated:YES];
            return controller;
        }
        
    }
    return nil;
}

#pragma markprivate method

- (UIButton *)navItemButtonWith:(NSString *)text image:(UIImage *)image{
    UIButton * itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    itemButton.frame = CGRectMake(0, 0, 40, 40);
    if (appTarget == AppTarget_Youhu) {
        [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [itemButton setTitleColor:SUBJECT_COLOR forState:UIControlStateNormal];
    }
    itemButton.titleLabel.font = [UIFont systemFontOfSize:Nav_Bar_Item_Font];
    [itemButton setTitle:text forState:UIControlStateNormal];
    [itemButton setImage:image forState:UIControlStateNormal];
    if ([[itemButton titleForState:UIControlStateNormal] isNotNull]) {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:Nav_Bar_Item_Font],NSFontAttributeName, nil];
        CGFloat width = [text sizeWithAttributes:attribute].width;
        width += 10;
        itemButton.frame = CGRectMake(0, 0, MAX(width, 40), 40);
    }else if ([itemButton imageForState:UIControlStateNormal]) {
        UIImage * image = [itemButton imageForState:UIControlStateNormal];
        CGFloat width = image.size.width;
        width += 10;
        itemButton.frame = CGRectMake(0, 0, MAX(width, 40), 40);
    }
    return itemButton;
}

@end
