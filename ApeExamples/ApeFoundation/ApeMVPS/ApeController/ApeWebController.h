//
//  ApeWebController.h
//  Youhu
//
//  Created by Eton on 2016/10/25.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeViewController.h"

@interface ApeWebController : ApeViewController

@property (strong, nonatomic) NSURL *homeUrl;

/** 传入控制器、url、标题 */
+ (void)pushWithController:(UIViewController *)contro withUrlStr:(NSString *)urlStr withTitle:(NSString *)title;

@end
