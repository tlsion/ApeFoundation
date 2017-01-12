//
//  ApeTabBarController.m
//  Youhu
//
//  Created by Eton on 2016/10/25.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeTabBarController.h"

@interface ApeTabBarController ()

@end

@implementation ApeTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
}


/**
 * 自定义tabBar
 */
- (void)setupNavigationBar {
    
    self.tabBar.shadowImage = [UIImage imageWithColor:RGBS(231)];
    self.tabBar.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
    self.tabBar.tintColor = SUBJECT_COLOR;
}

#pragma mark - rewrite method

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    UIViewController * cViewController = [self viewControllerInTabWithIndex:self.selectedIndex];
    [super setSelectedIndex:selectedIndex];
    [cViewController.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - optional method

- (UIViewController *)viewControllerInTabWithIndex:(NSInteger )index {
    if (self.viewControllers.count < index) return nil;
    
    UIViewController * navigationController = [self.viewControllers objectAtIndex:index];
    if ([navigationController isKindOfClass:[UINavigationController class]]) {
        return [((UINavigationController *)navigationController).viewControllers firstObject];
    }else{
        return navigationController;
    }
}

- (UIViewController *)viewControllerInTabWithClass:(Class )vClass {
    
    for (UINavigationController * navigationController in self.viewControllers) {
        UIViewController * viewController = [((UINavigationController *)navigationController).viewControllers firstObject];
        if ([viewController isKindOfClass:vClass]) {
            return viewController;
        }
    }
    return nil;
}

/**
 *  通过class定位tab的控制器
 */
- (void)selectedViewControllerInTabBarWithClass:(Class )vClass{
    
    for (UINavigationController * navigationController in self.viewControllers) {
        UIViewController * viewController = [((UINavigationController *)navigationController).viewControllers firstObject];
        if ([viewController isKindOfClass:vClass]) {
            self.selectedViewController = navigationController;
            return;
        }
    }
}

- (UIViewController *)currentShowViewController{
    UINavigationController * cNC = (UINavigationController *)self.selectedViewController;
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:cNC.viewControllers];
    return [viewControllers lastObject];
}

- (id )setupViewController:(Class )cls {
    id viewController;
    if ([cls conformsToProtocol:@protocol(StoryboardLoader)]) {
        viewController = [cls loadFromStoryboard];
    }else{
        viewController = [[cls alloc] init];
    }
    return viewController;
}

- (ApeNavigationController *)setupNavViewController:(UIViewController *)viewController {
    ApeNavigationController *navigationController = [[ApeNavigationController alloc] initWithRootViewController:viewController];
    navigationController.delegate = self;
    return navigationController;
}

//#pragma mark - 横竖屏

//-(BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//- (UIInterfaceOrientation )preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationPortrait;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
