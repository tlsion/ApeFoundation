//
//  StoryboardLoader.h
//  zfbuser
//
//  Created by Eric Wang on 15/7/4.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LoadFromStoryboard(sName,sId) [[UIStoryboard storyboardWithName:sName bundle:nil] instantiateViewControllerWithIdentifier:sId]

@protocol StoryboardLoader <NSObject>

@required

+(id)loadFromStoryboard;

@end
