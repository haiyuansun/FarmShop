//
//  HYBaseTabBarViewController.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/13.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBaseNavController.h"

@interface HYBaseTabBarViewController : UITabBarController
/*
 * 是否隐藏tabBar
 */
@property (nonatomic, assign) BOOL tabBarHidden;

+(HYBaseTabBarViewController *)sharedController;

#pragma mark 是否隐藏tabBar
- (void)hidesTabBar:(BOOL)yesOrNO animated:(BOOL)animated;

- (void)addChildVc:(NSArray *)childVcs
            titles:(NSArray *)titles
            images:(NSArray *)images
    selectedImages:(NSArray *)selectedImages
 tabBarNaviChildVC:(HYBaseNavController*)tabBarNaviChildVC;
@end
