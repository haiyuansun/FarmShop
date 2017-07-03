//
//  HYSelectViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/16.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYSelectViewController.h"
#import "HYSelectTopView.h"
#import "HYSelectTypeView.h"
#import "HYBuyView.h"
#import "HYShopCartTool.h"
#import "HYShopListTool.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <Masonry/Masonry.h>

@interface HYSelectViewController ()
@property (nonatomic, strong) UIButton *backBtn;
//@property (nonatomic, strong) UIImageView *productImage;
@property (nonatomic, strong) HYSelectTopView *topView;
@property (nonatomic, strong) HYSelectTypeView *typeView;
@property (nonatomic, strong) HYBuyView *numberView;
@property (nonatomic, assign) int selectedNumber;
@end

@implementation HYSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    _backBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    [_backBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_backBtn];
//    _backBtn.frame = CGRectMake(0, 400, 30, 30);
    [self setupGestureRecognizer];

}
#pragma mark - setupUI
-(void)setupUI{
    //头部标签界面
    _topView = [[HYSelectTopView alloc] initWithProdcutImageUrlString:self.product.img price:[self.product.price doubleValue] productNumber:self.product.store_nums];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.leading.mas_equalTo(self.view);
        make.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
//    _topView.backgroundColor = [UIColor ht_jayColor];
    // 规格选择界面
    NSArray *array = @[@"购买组合1",@"购买组合15654645",@"那你真的很棒棒棒棒",@"购买组合1",@"购买组合1",@"购买组合1546456",@"购买组合1",@"购买组合14456",@"你今天真的太棒了"];
    _typeView = [[HYSelectTypeView alloc] initWithTitle:@"选择规格" Selections:array];
    [self.view addSubview:_typeView];
    [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(screenWidth);
        make.top.mas_equalTo(self.topView.mas_bottom).offset(10);
        make.height.mas_equalTo(200);
        make.leading.mas_equalTo(self.view);
    }];
    _typeView.backgroundColor = [UIColor whiteColor];
    //数量选择视图
    UILabel *numberLabel = [[UILabel alloc] init];
    [numberLabel setText:@"选择数量:"];
    [self.view addSubview:numberLabel];
    [numberLabel sizeToFit];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(20);
        make.top.mas_equalTo(self.typeView.mas_bottom).offset(20);
    }];
    numberLabel.font = [UIFont systemFontOfSize:15.f];
    _numberView = [[HYBuyView alloc] init];
    __weak __typeof(self) weakSelf = self;
    _numberView.changeBlock = ^(int number){
        weakSelf.selectedNumber = number;
    };
    _numberView.product = self.product;
    [self.view addSubview:_numberView];
    [_numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(numberLabel.mas_trailing).offset(20);
        make.top.mas_equalTo(self.typeView.mas_bottom).offset(20);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(25);
    }];
    //确认button
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确认购买" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [confirmBtn setBackgroundColor:ButtonColor];
    confirmBtn.titleLabel.font = ButtonTitleFont;
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"Button_plain"] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:@"Button_highlighted"] forState:UIControlStateHighlighted];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-self.view.height / 3);
        make.trailing.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
        make.leading.mas_equalTo(self.view.mas_centerX).offset(1);
    }];
    //购物车button
    UIButton *shopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [shopCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shopCartBtn setBackgroundImage:[UIImage imageNamed:@"Button_plain"] forState:UIControlStateNormal];
    [shopCartBtn setBackgroundImage:[UIImage imageNamed:@"Button_highlighted"] forState:UIControlStateHighlighted];
    [shopCartBtn addTarget:self action:@selector(shopCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    shopCartBtn.titleLabel.font = ButtonTitleFont;
    [self.view addSubview:shopCartBtn];
    [shopCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-self.view.height / 3);
        make.trailing.mas_equalTo(self.view.mas_centerX).offset(-1);
        make.height.mas_equalTo(40);
        make.leading.mas_equalTo(self.view);
    }];


}
//topView


#pragma mark - setupGestureRecognizer
-(void)setupGestureRecognizer{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidSwipe:)];
    [self.view addGestureRecognizer:swipe];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
}

#pragma mark - methods
-(void)viewDidSwipe: (UISwipeGestureRecognizer *)swipe{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)confirmBtnClick:(UIButton *)button{
    DLog(@"confirmBtnClick");
    /*添加订单*/
    if(self.selectedNumber > 0){
        HYShopListTool *sharedTool = [HYShopListTool sharedListTool];
        [sharedTool userCreateListWithItem:self.product];
        self.product.itemNumOnList = self.selectedNumber;
        self.product.userBuyNumber = 0;
        NSArray *lists = [sharedTool getUserLists];
        [SVProgressHUD showSuccessWithStatus:@"已为您加入订单"];
        [SVProgressHUD dismissWithDelay:1.0];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [SVProgressHUD showInfoWithStatus: @"您尚未选择数量"];
        [SVProgressHUD dismissWithDelay:0.5];
    }

//    DLog(@"%@", lists);
}
-(void)shopCartBtnClick:(UIButton *)button {
    DLog(@"shopCartBtnClick");

    if (self.selectedNumber > 0) {
        [[HYShopCartTool sharedCartTool]addSupermarkProductToShopCarWithGoods:self.product WithNumber:self.selectedNumber];
        [[NSNotificationCenter defaultCenter] postNotificationName:HYShopCartBuyNumberDidChangeNofitication object:nil];
        [SVProgressHUD showSuccessWithStatus:@"已为您加入购物车"];
        [SVProgressHUD dismissWithDelay:1.0];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [SVProgressHUD showInfoWithStatus: @"您尚未选择数量"];
        [SVProgressHUD dismissWithDelay:0.5];
    }
    //    sleep(1);

}

@end
