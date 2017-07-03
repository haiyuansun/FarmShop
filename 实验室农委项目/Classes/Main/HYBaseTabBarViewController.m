//
//  HYBaseTabBarViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/13.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYBaseTabBarViewController.h"
#import "HYBaseTabBarButton.h"
#import "HomeViewController.h"
#import "RecViewController.h"
#import "ShopCartViewController.h"
#import "ProfileViewController.h"
#import "HYBaseNavController.h"

#define kTabBarHeight 49

@interface HYBaseTabBarViewController ()
/** 自定义的覆盖原先的tarbar的控件 */
@property (nonatomic, strong) UIView *tabBarView;
/** 记录前一次选中的按钮 */
@property (nonatomic, strong) HYBaseTabBarButton *selectLastBtn;

@end

@implementation HYBaseTabBarViewController

//单例
static HYBaseTabBarViewController *controller = nil;
+(HYBaseTabBarViewController *)sharedController{
    @synchronized(self){
        if(controller == nil){
            controller = [[self alloc] init];
            [controller buildTabBar];
            NSArray *titles = @[@"首页",@"闪电超市",@"购物车",@"我的"];
            NSArray *vcs = @[[[HomeViewController alloc]init],[[RecViewController alloc]init],[[ShopCartViewController alloc]init],[[ProfileViewController alloc]init]];
            NSArray *images = @[@"v2_home",@"v2_order",@"shopCart",@"v2_my"];
            NSArray *selectedImages = @[@"v2_home_r",@"v2_order_r",@"shopCart_r",@"v2_my_r"];
            [controller addChildVc:vcs titles:titles images:images selectedImages:selectedImages tabBarNaviChildVC:[[HYBaseNavController alloc]init]];
        }
    }
    return controller;
}
+(instancetype)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (controller == nil) {
            controller = [super allocWithZone:zone];
            return  controller;
        }
    }
    return nil;
}

- (void)buildTabBar{
    self.tabBar.hidden = YES;
    CGFloat tabBarViewY = self.view.frame.size.height - 49;
    _tabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, tabBarViewY, screenHeight, 49)];
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.backgroundColor = [UIColor whiteColor];
    _tabBarView.alpha = 0.98;
    [self.view addSubview:_tabBarView];
}

- (void)addChildVc:(NSArray *)childVcs titles:(NSArray *)titles images:(NSArray *)images selectedImages:(NSArray *)selectedImages tabBarNaviChildVC:(HYBaseNavController *)tabBarNaviChildVC{
    for (int i = 0; i < childVcs.count; ++i) {
        UINavigationController *tabBarNaviChildVC = [[UINavigationController alloc]
                                                     initWithRootViewController:childVcs[i]];
        
        [self addChildViewController:tabBarNaviChildVC];
        
        [self creatButtonWithNormalName:images[i]
                          andSelectName:selectedImages[i]
                               andTitle:titles[i] andTag:i
                               andIndex:childVcs.count] ;
    }
    
    HYBaseTabBarButton * button = self.tabBarView.subviews[0];
    [self changeViewController:button];
    
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(HYBaseTabBarButton *)sender
{
    sender.enabled = NO;
    if (_selectLastBtn != sender) {
        _selectLastBtn.enabled = YES;
    }
    _selectLastBtn = sender;
    self.selectedViewController = self.viewControllers[sender.tag];
}
#pragma mark 创建一个按钮

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andTag:(int)tag andIndex:(NSInteger)index{
    
    HYBaseTabBarButton * customButton = [HYBaseTabBarButton buttonWithType:UIButtonTypeCustom];
    customButton.tag = tag;
    NSInteger count = index;
    CGFloat buttonW = _tabBarView.frame.size.width /  count;
    CGFloat buttonH = _tabBarView.frame.size.height;
    customButton.frame = CGRectMake(buttonW * tag, 0, buttonW, buttonH);
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:12];
    NSLog(@"customFrame = %@",NSStringFromCGRect(customButton.frame));
    [_tabBarView addSubview:customButton];
}

#pragma mark 是否隐藏tabBar
- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated
{
    self.tabBarHidden = yesOrNO;
    if (yesOrNO == YES)
    {
        if (self.tabBarView.frame.origin.y == self.view.frame.size.height)
        {
            return;
        }
    }
    else
    {
        if (_tabBarView.frame.origin.y == self.view.frame.size.height - kTabBarHeight)
        {
            return;
        }
    }
    if (animated == YES)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        if (yesOrNO == YES)
        {
            _tabBarView.frame = CGRectMake(_tabBarView.frame.origin.x, _tabBarView.frame.origin.y + kTabBarHeight, _tabBarView.frame.size.width, _tabBarView.frame.size.height);
        }
        else
        {
            _tabBarView.frame = CGRectMake(_tabBarView.frame.origin.x, _tabBarView.frame.origin.y - kTabBarHeight, _tabBarView.frame.size.width, _tabBarView.frame.size.height);
        }
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        if (yesOrNO == YES)
        {
            _tabBarView.frame = CGRectMake(_tabBarView.frame.origin.x, _tabBarView.frame.origin.y + kTabBarHeight, _tabBarView.frame.size.width, _tabBarView.frame.size.height);
        }
        else
        {
            _tabBarView.frame = CGRectMake(_tabBarView.frame.origin.x, _tabBarView.frame.origin.y - kTabBarHeight, _tabBarView.frame.size.width, _tabBarView.frame.size.height);
        }
        [UIView commitAnimations];
    }
}



@end
