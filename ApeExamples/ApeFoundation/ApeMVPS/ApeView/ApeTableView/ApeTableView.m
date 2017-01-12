//
//  ApeTableView.m
//  Youhu
//
//  Created by Eton on 2016/10/29.
//  Copyright © 2016年 ApeStar. All rights reserved.
//

#import "ApeTableView.h"
#import "MJRefresh.h"

@interface ApeTableView ()

@property (nonatomic, assign) NSInteger nextPage;

// 是否有更多数据
@property (nonatomic, assign) BOOL isEnd;

@end
@implementation ApeTableView
//- (instancetype)init {
//    
//    if (self = [super init]) {
//        
//        [self addRefreshWidget];
//    }
//    
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addRefreshWidget];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        [self addRefreshWidget];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self addRefreshWidget];
    }
    
    return self;
}

// 添加MJRefresh下拉刷新、上拉加载控件
- (void)addRefreshWidget {
    
    _autoReloadData = YES;
    
    _nextPage = FIRST_PAGE;
    
    __weak typeof(self) weakSelf = self;
    
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.nextPage = FIRST_PAGE;
        
        weakSelf.isEnd = NO;
        
//        // 下拉刷新时删除之前数据(会有问题)
//        _dataList = [NSArray array];
        
        [weakSelf.refreshDelegate tableView:weakSelf loadDataOnPage:weakSelf.nextPage];
    }];
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf.refreshDelegate tableView:weakSelf loadDataOnPage:weakSelf.nextPage];
        
    }];
//    // 视图初始化时，执行一次下拉刷新
//    [self refresh];
}

- (void)refresh {
    
    [self endRefreshing];
    
    [self.mj_header beginRefreshing];
}
- (void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    // 在设置数据源后自动刷新
    if (_autoReloadData) {
        
        [self tx_reloadData];
    }
}

- (void)loadDataList:(NSArray *)dataList {
    
    if (self.nextPage == FIRST_PAGE) {
        _dataList = [NSArray array];
    }
    
//    if (dataList.count == 0 || dataList.count != _dataList.count) {
//        
//        [self tx_reloadData];
//    }
    
    // 如果请求到数据，页号加1
    if (dataList.count > 0) {
        
        _nextPage ++;
        _isEnd = NO;
    }else{
        _isEnd = YES;
    }
    
    // 因为每次下拉刷新都初始化datalist，所以可以用datalist初始化tempArray
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:_dataList];
    
    [tempArray addObjectsFromArray:dataList];
    
    _dataList = [tempArray copy];
    
    // 在设置数据源后自动刷新
    if (_autoReloadData) {
        
        [self tx_reloadData];
    }
    [self endRefreshing];
}

- (void)endRefreshing {
    
    if (self.mj_header.isRefreshing) {
        [self.mj_header endRefreshing];
    }
    
    if (_isEnd) {
        
        // 没有更多数据时，使用MJRefresh的提示
        [self.mj_footer endRefreshingWithNoMoreData];
        
    } else {
        
        if (self.mj_footer.isRefreshing) {
            [self.mj_footer endRefreshing];
        }
    }
}

// 清空数据库
- (void)clearDataList{
    self.nextPage = FIRST_PAGE;
    
    self.isEnd = NO;
    
    _dataList = [NSArray array];
    [self reloadData];
}

@end
