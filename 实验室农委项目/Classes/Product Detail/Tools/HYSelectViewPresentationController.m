//
//  HYSelectViewPresentationController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/16.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYSelectViewPresentationController.h"
#import "AnimatorPresentHalfTransition.h"

@interface HYSelectViewPresentationController()<UIViewControllerTransitioningDelegate>

@end

@implementation HYSelectViewPresentationController
#pragma mark - UIViewControllerTransitioningDelegate
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    HYSelectViewPresentationController *controller = [[HYSelectViewPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return controller;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    // Present Half
    AnimatorPresentHalfTransition *presentHalfTransition = [[AnimatorPresentHalfTransition alloc] init];
    presentHalfTransition.animatorTransitionType = kAnimatorTransitionTypeDismiss;
    return presentHalfTransition;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    // Present Half
    AnimatorPresentHalfTransition *presentHalfTransition = [[AnimatorPresentHalfTransition alloc] init];
    presentHalfTransition.animatorTransitionType = kAnimatorTransitionTypePresent;
    return presentHalfTransition;
}

@end
