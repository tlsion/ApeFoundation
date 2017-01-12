//
//  ApeTableViewController.m
//  Youhu
//
//  Created by Eton on 2016/10/29.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeTableViewController.h"

@interface ApeTableViewController ()

@end

@implementation ApeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupContentTableView];
    [self.tableView refresh];
}

- (void)setupContentTableView {
    if (!self.tableView) {
        self.tableView = [[ApeTableView alloc] init];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.refreshDelegate = self;
        [self.view insertSubview:self.tableView atIndex:0];
        kWeakSelf;
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view);
        }];
    }
}

#pragma mark - ApeTableViewDelegate子类重写

- (void)tableView:(ApeTableView *)tableView loadDataOnPage:(NSUInteger)page {
    
}


#pragma mark - UITableViewDelegate 、UITableDataSource 子类重写
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableView.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
