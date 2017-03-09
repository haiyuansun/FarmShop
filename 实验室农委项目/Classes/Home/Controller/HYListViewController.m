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

#define listCellIdentifier @"HYListCell"

@interface HYListViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *listModels;
@end

@implementation HYListViewController

#pragma mark - 懒加载
-(NSArray *)listModels{
    if (!_listModels) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"listTable.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *Marr = [NSMutableArray array];
        for(NSDictionary *dict in array){
            HYListModel *model = [[HYListModel alloc] initWithDict:dict];
            [Marr addObject:model];
        }
        _listModels = [Marr copy];
    }
    return _listModels;
}

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        UISearchBar *sb = [[UISearchBar alloc] init];
//        [self.navigationController.navigationBar addSubview:sb];
        sb.frame = CGRectMake(70, 7, WIDTH * 0.7, 30);
//        sb.placeholder = @"....";
        _searchBar = sb;
        sb.delegate = self;
    }
    return _searchBar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self initSearchBar];
//    [self.navigationController.navigationBar addSubview:self.searchBar];
    self.navigationItem.titleView = self.searchBar;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HYListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:listCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - initItems

#pragma mark - internal methods
-(void)setSearchStr:(NSString *)searchStr{
    _searchStr = searchStr;
    self.searchBar.text = searchStr;
//    self.searchBar.prompt  = searchStr;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar endEditing:YES];
}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//
//}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.searchBar removeFromSuperview];
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    DLog(@"%@", searchBar.text);
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    HYDetailViewController *vc = [[HYDetailViewController alloc] init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HYDetailStoryboard" bundle:nil];
    HYDetailViewController *vc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableviewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listModels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYListCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellIdentifier];
    cell.listModel = self.listModels[indexPath.row];
    return cell;
}



@end
