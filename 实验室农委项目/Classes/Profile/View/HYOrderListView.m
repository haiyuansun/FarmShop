//
//  HYOrderListView.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/28.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYOrderListView.h"
#import "HYShopList.h"
#import "HYOrderCell.h"
#import "HYOrderHeaderView.h"
//#import "UIView+AdjustFrame.h"
#import <Masonry/Masonry.h>

#define orderListIdentifier @"orderListIdentifier"

@interface HYOrderListView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *lists;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *defaultView;
@end

@implementation HYOrderListView
-(instancetype)initWithOrderLists:(NSArray *)lists{
    if (self = [super init]) {
        self.lists = lists;
        [self setupUI];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.lists.count == 0) {
        self.tableView.hidden = YES;
        self.defaultView.hidden = NO;
    }else{
        self.tableView.hidden = NO;
        self.defaultView.hidden = YES;
    }
}
#pragma mark methods
-(void)reloadData{
    [self.tableView reloadData];
}

#pragma mark - setupUI
-(void)setupUI{
    /*tableview*/
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 80;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.style = UITableViewStyleGrouped;

    [_tableView registerClass:[HYOrderCell class] forCellReuseIdentifier:orderListIdentifier];
    [self addSubview:_tableView];
    _tableView.hidden = YES;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 44)];
//    headerView.backgroundColor = [UIColor ht_leadColor];
//
//    _tableView.tableHeaderView = headerView;
    /*defaultView*/
    _defaultView = [[UIView alloc] init];
    [self addSubview:_defaultView];
    _defaultView.hidden = YES;
    [_defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"您尚未购买过商品";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    [self.defaultView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.trailing.equalTo(self);
        make.center.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - UITableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.lists.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HYShopList *list = self.lists[section];
    return list.userBuyProducts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderListIdentifier];
    HYShopList *list = self.lists[indexPath.section];
    cell.product = [list.userBuyProducts objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - UITableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    DLog(@"%ld", (long)section);
    // 取出订单
    HYShopList *list = self.lists[section];
    HYOrderHeaderView *headerView = [[HYOrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
    headerView.createStr = list.createTime;
    headerView.listId = list.listId;
    headerView.backgroundColor = [UIColor colorWithRed:212.f/255 green:230.f/255 blue:247.f/255 alpha:1.0];
    return headerView;
}


@end
