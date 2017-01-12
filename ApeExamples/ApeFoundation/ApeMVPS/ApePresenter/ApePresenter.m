//
//  ApePresenter.m
//  Youhu
//
//  Created by Eton on 2016/10/28.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApePresenter.h"

@implementation ApePresenter

- (id)init{
    self = [super init];
    if (self) {
        [self initModule];
    }
    return self;
}

- (void)initModule{
    NSString * clsString = NSStringFromClass([self class]);
    if ([clsString hasSuffix:@"Presenter"]) {
        clsString = [clsString stringByReplacingOccurrencesOfString:@"Presenter" withString:@"Module"];
        
        Class moduleCls = NSClassFromString(clsString);
        if (moduleCls) {
           self.baseModule = [[moduleCls alloc] init];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
