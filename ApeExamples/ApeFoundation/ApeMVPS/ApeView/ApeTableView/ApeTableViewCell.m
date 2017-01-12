//
//  ApeTableViewCell.m
//  Youhu
//
//  Created by Eton on 2016/11/14.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeTableViewCell.h"

@implementation ApeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
