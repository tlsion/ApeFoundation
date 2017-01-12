//
//  ApeViewController.h
//  Youhu
//
//  Created by Eton on 2016/10/25.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApePresenter.h"
#import "ApeTablePlaceHolderView.h"
#import "UITableView+PlaceHolder.h"
@class FailureResponseModel;

@interface ApeViewController : UIViewController<UITableViewPlaceHolderDelegate>
@property (nonatomic, strong) ApePresenter * basePresenter;

@property (nonatomic, assign) BOOL didFirstLoad; //是否完成第一次加载，逻辑使用

@property (nonatomic, strong) ApeTablePlaceHolderView *o_placeHolderView;

#pragma mark - Loading methods
- (void)showLoading;
- (void)disLoading;
- (void)loadingFailure:(NSError *)failureResponse;

@end
