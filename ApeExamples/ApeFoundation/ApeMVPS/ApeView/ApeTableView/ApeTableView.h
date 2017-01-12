//
//  ApeTableView.h
//  Youhu
//
//  Created by Eton on 2016/10/29.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApeTableView;

@protocol ApeTableViewDelegate <NSObject>

// 在使用ApeTableView的页面实现代理方法，代理方法用于请求数据
- (void)tableView:(ApeTableView *)tableView loadDataOnPage:(NSUInteger)page;

@end

@interface ApeTableView : UITableView

@property (nonatomic, weak) IBOutlet id<ApeTableViewDelegate>refreshDelegate;

// 是否在数据请求成功后自动重新加载
@property (nonatomic, assign) BOOL autoReloadData;

// tableview数据源，用于存储网络请求数据
@property (nonatomic, strong) NSArray *dataList;

// 加载tableview数据源，用于存储网络请求数据
- (void)loadDataList:(NSArray *)dataList;

// 下拉刷新
- (void)refresh;

// 建议在网络请求block的最外传使用，避免网络不好时一直转菊花
- (void)endRefreshing;

// 清空数据库
- (void)clearDataList;


@end
