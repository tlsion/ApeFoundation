//
//  ApeParam.h
//  Youhu
//
//  Created by Eton on 2016/11/26.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <Mantle/Mantle.h>
@interface ApeParam : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy) NSString * page;
@property (nonatomic, copy) NSString * size;

@end
