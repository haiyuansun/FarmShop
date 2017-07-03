//
//  HYMainTabBarController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/13.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYMainTabBarController.h"
#import "HomeViewController.h"
#import "RecViewController.h"
#import "ShopCartViewController.h"
#import "ProfileViewController.h"
#import "HYBaseNavController.h"

@interface HYMainTabBarController ()

@end

@implementation HYMainTabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self addMainTabBarController];
//    [self addNotification];
}



- (void)addMainTabBarController
{
    
    
    [self setupChildViewController:@"首页" viewController:[HomeViewController new] image:@"v2_home" selectedImage:@"v2_home_r"];
    [self setupChildViewController:@"推荐" viewController:[RecViewController new] image:@"v2_order" selectedImage:@"v2_order_r"];
    [self setupChildViewController:@"购物车" viewController:[ShopCartViewController new] image:@"shopCart" selectedImage:@"shopCart_r"];
    [self setupChildViewController:@"我" viewController:[ProfileViewController new] image:@"v2_my" selectedImage:@"v2_my_r"];
    
}
//- (void)addNotification{
//    [AJNotification addObserver:self selector:@selector(IncreaseShoppingCart) name:LFBShopCarBuyNumberDidChangeNotification object:nil];
//}
//- (void)IncreaseShoppingCart{
//    UIViewController *shoppingVC = self.childViewControllers[2];
//    NSInteger shoppingIndex = [[AJUserShopCarTool sharedInstance]getShopCarGoodsNumber];
//    if (shoppingIndex == 0) {
//        shoppingVC.tabBarItem.badgeValue = nil;
//        return;
//    }
//    shoppingVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",shoppingIndex];
//}
//- (void)dealloc{
//    [AJNotification removeObserver:self];
//}

- (void)setupChildViewController:(NSString *)title viewController:(UIViewController *)controller image:(NSString *)image selectedImage:(NSString *)selectedImage {
    UITabBarItem *item = [[UITabBarItem alloc]init];
    item.image = [UIImage imageNamed:image];
    item.selectedImage = [UIImage imageNamed:selectedImage];
    item.title = title;
    controller.tabBarItem = item;
    controller.title = title;
    HYBaseNavController *naController = [[HYBaseNavController alloc]initWithRootViewController:controller];
    [self addChildViewController:naController];
}
@end

