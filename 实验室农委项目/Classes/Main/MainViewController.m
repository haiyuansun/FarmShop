//
//  MainViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/11.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "MainViewController.h"
#import "UIImage+Fit.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = tColor;
//    self.tabBar.itemWidth = 40;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  改变图片的大小
 *
 *  @param img     需要改变的图片
 *  @param newsize 新图片的大小
 *
 *  @return 返回修改后的新图片
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
