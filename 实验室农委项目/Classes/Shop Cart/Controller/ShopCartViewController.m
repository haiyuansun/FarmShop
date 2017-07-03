//
//  ShopCartViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/13.
//  Copyright © 2017年 孙海源. All rights reserved.
//


#import "ShopCartViewController.h"
#import "HYDefaultView.h"
#import "HYCartHeadView.h"
#import "HYShopCartCell.h"
#import <Masonry/Masonry.h>
#import "HYGoods.h"
#import "HYGoodsViewModel.h"
#import "HYCartTableFootView.h"
#import "HYShopCartTool.h"
#import "HYShopListTool.h"

#define identifier @"cell"

@interface ShopCartViewController ()<UITableViewDelegate, UITableViewDataSource, HYCartTableFootViewDelegate>
@property (nonatomic, strong) HYDefaultView *defaultView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) HYCartTableFootView *footView;
//@property (nonatomic, assign) int totalMoney;
@end

@implementation ShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createDefaultView];
    [self createTableView];

    [self initNotification];
//    [self.tableView reloadData];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, tabbarHeight, 0);
}
// refresh UI
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
    if (self.dataList.count == 0) {
        self.defaultView.hidden = NO;
        self.tableView.hidden = YES;
    }else{
        self.defaultView.hidden = YES;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
//    DLog(@"viewWillAppear");
}
#pragma mark - methods
- (void)loadData {
//    HYSuperMarketData *superMarketData = [[HYGoodsViewModel sharedGoodsViewModel] loadGoods];
//    ProductCategory *category = superMarketData.categories[1];
    self.dataList = [HYShopCartTool sharedCartTool].shopCarGoods;
}
-(void)shoppingCartItemsDidChange{
    self.footView.sumMoney = [[HYShopCartTool sharedCartTool] getShopCarGoodsPrice];
}
-(void)shoppingCartItemDidRemove{
    self.footView.sumMoney = [[HYShopCartTool sharedCartTool] getShopCarGoodsPrice];
}

#pragma mark - init

-(void)initNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartItemsDidChange) name:HYShopCartBuyNumberDidChangeNofitication object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartItemDidRemove) name:HYShopCartRemoveProductNofitication object:nil];
}

- (void)createTableView{
    self.tableView = ({
        UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.rowHeight = 80;
        //tableview.hidden = YES;
        tableview.backgroundColor = [UIColor clearColor];
        tableview;
    });
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerClass:[HYShopCartCell class] forCellReuseIdentifier:identifier];
    [self createTableHeadView];
    [self createTableFootView];
}
-(void)createTableHeadView{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
//    AJAddressView *address = [[AJAddressView alloc]initWithFrame:CGRectMake(0, 10, Width, 50)];
    HYCartHeadView *lightning = [[HYCartHeadView alloc]initWithFrame:CGRectMake(0, 5, screenWidth, 30)];
//    [self.headView addSubview:address];
    [self.headView addSubview:lightning];
    self.tableView.tableHeaderView = self.headView;

}
-(void)createTableFootView{
    _footView = [[HYCartTableFootView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
    _footView.delegate = self;
    _footView.sumMoney = [[HYShopCartTool sharedCartTool] getShopCarGoodsPrice];
    self.tableView.tableFooterView = _footView;

}
- (void)createDefaultView{
    _defaultView = [[HYDefaultView alloc]init];
    _defaultView.hidden = YES;
    [self.view addSubview:_defaultView];
    [_defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(170);
    }];
}

#pragma mark - UITableViewDelegate


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
         cell = [[HYShopCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.product = self.dataList[indexPath.row];
    return cell;
}
#pragma mark - HYCartTableFootViewDelegate

-(void)didTableFootViewCommit{
    DLog(@"didTableFootViewCommit");
    HYShopListTool *tool = [HYShopListTool sharedListTool];
//    NSArray *products = 
    [tool userCreateListWithItems:self.dataList andTotalCost:[[HYShopCartTool sharedCartTool] getShopCarGoodsPrice]];
    [self.dataList enumerateObjectsUsingBlock:^(HYGoods*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.itemNumOnList = obj.userBuyNumber;
    }];
    [[HYShopCartTool sharedCartTool] removeAllProducts];
    [self.tableView reloadData];
//    [HYShopCartTool sharedCartTool] 
    NSArray *arr = [tool getUserLists];
}




@end
