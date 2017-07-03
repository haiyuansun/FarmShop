//
//  ProfileViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/13.
//  Copyright © 2017年 孙海源. All rights reserved.
//


#import "ProfileViewController.h"
#import "AccountViewModel.h"
#import "UserAccount.h"
#import "UIView+AdjustFrame.h"
#import "HMSegmentedControl.h"
#import "HYProfileView.h"
#import "HYLikeView.h"
#import "HYGoods.h"
#import "HYGoodsViewModel.h"
#import "HYShopListTool.h"
#import "HYDetailViewController.h"
#import "HYOrderListView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface ProfileViewController ()
@property (nonatomic, strong) HMSegmentedControl *segment;
@property (nonatomic, strong) HYProfileView *profileView;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UserAccount *userAccount;
@property (nonatomic, strong) HYLikeView *likeView;
@property (nonatomic, strong) HYOrderListView *orderView;
@property (nonatomic, strong) NSArray *userLikeProducts;

@end

@implementation ProfileViewController


#pragma mark - 懒加载
- (NSArray *)userLikeProducts{
    if (!_userLikeProducts) {
        _userLikeProducts = [self loadUserLikeProducts];
    }
    return _userLikeProducts;
}

-(UserAccount *)userAccount{
    if (!_userAccount) {
        _userAccount = [[AccountViewModel alloc] init].userAccount;
    }
    return _userAccount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.orderView reloadData];
    [self setupUI];
}
#pragma mark setupUI
-(void)setupUI{
    self.navigationController.navigationBar.tintColor = tColor;
    __weak __typeof(self) weakSelf = self;
//    self.view.backgroundColor = GeneralColor;
    //segment
    UIImage *setting = [UIImage imageNamed:@"setting"];
    UIImage *like = [UIImage imageNamed:@"like"];
//    UIImage *setting_s = [UIImage imageNamed:@"setting-selected"];
//    UIImage *like_s = [UIImage imageNamed:@"like-selected"];
    UIImage *list = [UIImage imageNamed:@"list"];
//    UIImage *list_s = [UIImage imageNamed:@"list-selected"];
    NSArray *images = @[setting, like, list];
//    NSArray *selected_images = @[setting_s, like_s, list_s];
    HMSegmentedControl *segment = [[HMSegmentedControl alloc] initWithSectionImages:images sectionSelectedImages:images];
    segment.backgroundColor = [UIColor ht_mintColor];
    segment.selectionIndicatorColor = tColor;
    segment.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segment.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.segment = segment;

    [self.view addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.leading.and.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    /* profile view */
    _profileView = [[HYProfileView alloc] initWithUserAccount:self.userAccount];
    [self.view addSubview:_profileView];
//    view.frame = CGRectMake(0, 60, screenWidth, screenHeight - 60);
    [_profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    
    }];
    _profileView.block = ^(NSUInteger index){
        DLog(@"%ld", index);
        if (index == 5) {
//            [weakSelf showAlert];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"message:@"是否要注销该用户？"preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [weakSelf clearArchiver];
                [[NSNotificationCenter defaultCenter] postNotificationName:HYRootViewControllerChangeName object:@{@"isVisitor":@"YES"}];
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            UIAlertAction* closeAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
//                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            
            
            [alert addAction:defaultAction];
            [alert addAction:closeAction];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    };
    /*like view*/
//    HYShopListTool *sharedTool = [HYShopListTool sharedListTool];
    _likeView = [[HYLikeView alloc] initWithLikeProducts: [self loadUserLikeProducts]];
    [self.view addSubview:_likeView];
    [_likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    _likeView.hidden = YES;
    _likeView.block = ^(NSUInteger index){
        HYGoods *product = weakSelf.userLikeProducts[index];
//        HYDetailViewController *vc = [[HYDetailViewController alloc] init];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HYDetailStoryboard" bundle:nil];
        HYDetailViewController *vc = [sb instantiateInitialViewController];
        vc.product = product;
//        vc.product
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    /*订单显示界面*/
    _orderView = [[HYOrderListView alloc] initWithOrderLists:[[HYShopListTool sharedListTool] getUserLists]];
    [self.view addSubview:_orderView];
    [_orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    DLog(@"%f", _orderView.y);
    _orderView.backgroundColor = [UIColor ht_cloudsColor];
    _orderView.hidden = YES;

}

#pragma mark - methods
-(void)segmentValueChanged: (HMSegmentedControl *)segment{
    DLog(@"%ld", (long)segment.selectedSegmentIndex);
    if (segment.selectedSegmentIndex == 0) {
        self.profileView.hidden = NO;
        self.likeView.hidden = YES;
        self.orderView.hidden = YES;
    }
    else if(segment.selectedSegmentIndex == 1){
        self.profileView.hidden = YES;
        self.likeView.hidden = NO;
        self.orderView.hidden = YES;
    }else{
        self.profileView.hidden = YES;
        self.likeView.hidden = YES;
        self.orderView.hidden = NO;
    }
}
-(NSArray *)loadUserLikeProducts{
    NSMutableArray *M_Arr = [NSMutableArray array];
    HYSuperMarketData *data = [[HYGoodsViewModel sharedGoodsViewModel] loadGoods];

    while([M_Arr count] < 20){
        NSArray *array = data.products;
        int r = arc4random() % array.count;
        [M_Arr addObject: [data.products objectAtIndex:r]];
    }

    return [M_Arr copy];
}
-(void)clearArchiver{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [documentPath stringByAppendingPathComponent:HYUserAccountArchiveName];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDelete = [manager isDeletableFileAtPath:path];
    if (isDelete) {
        [manager removeItemAtPath:path error:nil];
    }
}
@end
