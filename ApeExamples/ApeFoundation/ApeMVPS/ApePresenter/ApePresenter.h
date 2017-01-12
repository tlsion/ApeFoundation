//
//  ApePresenter.h
//  Youhu
//
//  Created by Eton on 2016/10/28.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ApeModule;
@class ApeViewController;

@interface ApePresenter : NSObject

@property (nonatomic, strong)  ApeModule * baseModule;
@property (nonatomic, weak)  ApeViewController * baseVC;

@end
