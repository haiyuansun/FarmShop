//
//  HYBaseNavController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/13.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYBaseNavController.h"

@interface HYBaseNavController ()
@property (nonatomic,strong) UIButton *backBtn;
@end

@implementation HYBaseNavController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"v2_goback"] forState:UIControlStateNormal];
        btn.titleLabel.hidden = YES;
        [btn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment  = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        btn.frame = CGRectMake(0, 0, 44, 40);
        btn;
    });
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        //取消自定义返回按钮 可以支持系统自带右滑返回上一级控制器功能
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
//        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backBtnClicked:(UIButton *)btn {
    [self popViewControllerAnimated:YES];
}
@end
