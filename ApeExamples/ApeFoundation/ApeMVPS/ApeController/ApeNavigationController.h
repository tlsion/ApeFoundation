//
//  ApeNavigationController.h
//  Youhu
//
//  Created by Eton on 2016/10/25.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApeNavigationController : UINavigationController<UIGestureRecognizerDelegate>

@property (strong, nonatomic, readonly) UIViewController * rootViewController;

@end
