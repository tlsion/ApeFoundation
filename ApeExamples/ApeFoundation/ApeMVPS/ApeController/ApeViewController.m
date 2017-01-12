//
//  ApeViewController.m
//  Youhu
//
//  Created by Eton on 2016/10/25.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeViewController.h"
#import "ApePresenter.h"
#import "BaseUserModel.h"

@interface ApeViewController ()

@property (nonatomic, assign) BOOL isLoding;

@end

@implementation ApeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initPresenter];
    
    //自动添加"后退"按钮
    NSArray *controllers = self.navigationController.viewControllers;
    if ((controllers.count > 1 && [controllers objectAtIndex:controllers.count-1] == self)) {
        [self crateBackButton];
    }
    
    self.view.backgroundColor = MAIN_BG_COLOR;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = true;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (appTarget == AppTarget_Youhu) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else if (appTarget == AppTarget_Apestar || appTarget == AppTarget_Joke) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
    //因ip6+ 经常出现状态栏隐藏问题，此处加以保护
    [UIApplication sharedApplication].statusBarHidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.didFirstLoad = YES;
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

#pragma mark - Init
- (void)initPresenter{
    NSString * clsString = NSStringFromClass([self class]);
    if ([clsString hasSuffix:@"ViewController"]) {
        clsString = [clsString stringByReplacingOccurrencesOfString:@"ViewController" withString:@"Presenter"];
        
        Class presenterCls = NSClassFromString(clsString);
        if (presenterCls) {
            self.basePresenter = [[presenterCls alloc] init];
            self.basePresenter.baseVC = self;
        }
    }
}


#pragma mark - GET placeHolderView

- (ApeTablePlaceHolderView *)o_placeHolderView{
    if (_o_placeHolderView) {
        return _o_placeHolderView;
    }
    _o_placeHolderView = [ApeTablePlaceHolderView loadFromNIB];
    
    return _o_placeHolderView;
}

#pragma mark - UITableViewPlaceHolderDelegate

- (UIView *)makePlaceHolderView{
    return self.o_placeHolderView;
}


#pragma mark - HUD
- (void)showLoading{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.isLoding = YES;
}

- (void)disLoading{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.isLoding = NO;
}

- (void)loadingFailure:(NSError *)failureResponse{
    self.isLoding = NO;
    [self disLoading];
    [MBProgressHUD tx_showError:[(FailureResponseModel *)failureResponse errorMessage] toView:self.view];
}

#pragma mark - dealloc

-(void) dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
#ifdef DEBUG
    NSLog(@"Class %@ dealloc -----!-----\n\n",[self class]);
#endif
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
