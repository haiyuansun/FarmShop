//
//  HYListViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/7.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYListViewController.h"
#import <Masonry/Masonry.h>
#import "HYListModel.h"
#import "HYDetailViewController.h"
#import "HYGoods.h"


#define listCellIdentifier @"HYListCell"

@interface HYListViewController ()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation HYListViewController

#pragma mark - 懒加载
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self initSearchBar];
//    [self.navigationController.navigationBar addSubview:self.searchBar];
//    self.navigationItem.titleView = self.searchBar;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    [self.tableView registerNib:[UINib nibWithNibName:@"HYListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:listCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.title = @"列表";
    self.navigationController.navigationBar.tintColor = tColor;
    
}


#pragma mark - initItems

#pragma mark - internal methods
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [self.searchBar removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    HYDetailViewController *vc = [[HYDetailViewController alloc] init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HYDetailStoryboard" bundle:nil];
    HYDetailViewController *vc = [sb instantiateInitialViewController];
    HYGoods *product = self.products[indexPath.row];
    vc.product = product;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UITableviewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.products.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    HYListCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellIdentifier forIndexPath:indexPath];
    HYListCell *cell = [[NSBundle mainBundle] loadNibNamed:@"HYListCell" owner:nil options:nil].lastObject;
    cell.goodModel = self.products[indexPath.row];
    return cell;
}



@end
