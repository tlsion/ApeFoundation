//
//  UIView+tap.m
//  zfbuser
//
//  Created by sansan on 15-9-3.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "UIView+tap.h"
#import <objc/runtime.h>


@implementation UIView (tap)

static const char * KeyTapGes = "KeyTapGes";
static const char * KeyLongPressGes = "KeyLongPressGes";

static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerLongPressBlockKey;
static char kDTActionHandlerLongPressGestureKey;

-(void)removeAllGesture
{
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIGestureRecognizer *ges = obj;
        [self removeGestureRecognizer:ges];
    }];
}

-(UITapGestureRecognizer *)addTapGesWithTarget:(id)sender action:(SEL)action
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = nil;
    tap = (UITapGestureRecognizer*)objc_getAssociatedObject(self, KeyTapGes);
    if (nil == tap) {
//        [self removeAllGesture];
        tap = [[UITapGestureRecognizer alloc] initWithTarget:sender action:action];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        tap.cancelsTouchesInView = YES;
        tap.delaysTouchesBegan = YES;
        tap.delaysTouchesEnded = YES;
        [self addGestureRecognizer:tap];
        tap.enabled = YES;
        objc_setAssociatedObject(self,KeyTapGes, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    };
    return tap;
}

-(UILongPressGestureRecognizer *)addLongPressGesWithTarget:(id)sender action:(SEL)action
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer * longPress = nil;
    longPress = (UILongPressGestureRecognizer *)objc_getAssociatedObject(self, KeyLongPressGes);
    if (nil == longPress) {
//        [self removeAllGesture];
        longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:sender action:action];
        longPress.minimumPressDuration = 0.8;
        [self addGestureRecognizer:longPress];
        longPress.enabled = YES;
        objc_setAssociatedObject(self,KeyLongPressGes, longPress, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    };
    return longPress;
}

-(void)addTapCallBack:(void (^)())block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self,&kDTActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
        if (action)
        {
            action();
        }
    }
}

- (void)addLongPressCallBack:(void (^)(void))block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerLongPressGestureKey);
    
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);
        
        if (action)
        {
            action();
        }
    }
}

@end
