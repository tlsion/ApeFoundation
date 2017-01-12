//
//  ApeTableViewCell.h
//  Youhu
//
//  Created by Eton on 2016/11/14.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ApePresenter;
@interface ApeTableViewCell : UITableViewCell

@property (nonatomic, strong) ApePresenter * presenter;//数据对象
@property (nonatomic, strong) NSObject * model;//数据对象
@property (nonatomic, strong) NSIndexPath * indexPath;//当前使用的位置

@end
