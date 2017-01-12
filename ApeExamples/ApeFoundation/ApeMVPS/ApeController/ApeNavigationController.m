//
//  ApeNavigationController.m
//  Youhu
//
//  Created by Eton on 2016/10/25.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeNavigationController.h"

@interface ApeNavigationController ()

@end

@implementation ApeNavigationController

- (UIViewController * )rootViewController{
    return [self.viewControllers firstObject];
};

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //支持右滑返回
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self setupNavigationBar];
}


/**
 * 自定义NavigationBar
 */
- (void)setupNavigationBar {
    self.navigationBar.translucent = false;
    
    if (appTarget == AppTarget_Youhu) {
        self.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0]};
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:SUBJECT_COLOR] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    }else if (appTarget == AppTarget_Apestar || appTarget == AppTarget_Joke) {
        self.navigationBar.tintColor = SUBJECT_COLOR;
        self.navigationBar.barTintColor = SUBJECT_COLOR;
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:SUBJECT_COLOR,NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0]};
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage imageWithColor:RGBS(231)]];
    }
    
}

#pragma mark - rewrite method

-(void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (self.viewControllers.count <= 1)//关闭主界面的右
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


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
