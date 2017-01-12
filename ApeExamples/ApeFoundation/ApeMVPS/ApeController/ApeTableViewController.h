//
//  ApeTableViewController.h
//  Youhu
//
//  Created by Eton on 2016/10/29.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeViewController.h"
#import "ApeTableView.h"

@interface ApeTableViewController : ApeViewController<UITableViewDelegate,UITableViewDataSource,ApeTableViewDelegate>

@property (nonatomic, strong) IBOutlet ApeTableView * tableView;

@end
