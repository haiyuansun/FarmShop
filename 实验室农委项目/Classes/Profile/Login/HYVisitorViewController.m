//
//  HYVisitorViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/21.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYVisitorViewController.h"
#import "OAuthViewController.h"

@interface HYVisitorViewController ()


@end

@implementation HYVisitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtnClick:(id)sender {
    OAuthViewController *vc = [[OAuthViewController alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
//    DLog(@"...");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
