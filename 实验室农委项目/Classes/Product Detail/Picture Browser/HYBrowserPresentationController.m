//
//  HYBrowserPresentationController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/16.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYBrowserPresentationController.h"
#import "AnimatorPresentZoomTransition.h"
@interface HYBrowserPresentationController()<UIViewControllerTransitioningDelegate>

@end

@implementation HYBrowserPresentationController
////Asks your delegate for the custom presentation controller to use for managing the view hierarchy when presenting a view controller.
//BOOL _isPresented = NO;
//
//-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
//    HYBrowserPresentationController *presentationController = [[HYBrowserPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
//    return presentationController;
//    
//}
////Asks your delegate for the transition animator object to use when presenting a view controller.
////只要遵守了UIViewControllerAnimatedTransitioning协议的对象就可以被返回
//-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    _isPresented = YES;
//    return self;
//}
////Asks your delegate for the transition animator object to use when dismissing a view controller.
////只要遵守了UIViewControllerAnimatedTransitioning协议的对象就可以被返回
//-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
//    _isPresented = NO;
//    return self;
//}
//
//-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
//    return 0.8;
//}
//
//-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
//    if (_isPresented) {
////        self.present
//        [self controllerWillPresent:transitionContext];
//    }else{
//        [self controllerWillDismiss:transitionContext];
//    }
//    
//}
//
//
//#pragma mark - custom methods
//-(void)controllerWillPresent: (id<UIViewControllerContextTransitioning>) transitionContext{
//    if (self.browserDelegate == nil) {
//        return;
//    }
//    UIView *containerView = [transitionContext containerView];
//    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
////    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//    if (![self.browserDelegate respondsToSelector:@selector(imageForBrowserWillShow:)]) {
//        return;
//    }
//    UIImage *image = [self.browserDelegate imageForBrowserWillShow:self];
//    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
//    iv.frame = [self.browserDelegate browserControllerWillShowFromFrame:self];
//    CGRect toFrame = [self.browserDelegate browserControllerWillShowToFrame:self];
//    [containerView addSubview:iv];
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        iv.frame = toFrame;
//    } completion:^(BOOL finished) {
//        [iv removeFromSuperview];
//        [containerView addSubview:toView];
//        BOOL wasCancelled = [transitionContext transitionWasCancelled];
//        [transitionContext completeTransition:!wasCancelled];
//        
//    }];
//    
//    
//}
//-(void)controllerWillDismiss: (id<UIViewControllerContextTransitioning>) transitionContext{
//    [transitionContext completeTransition:YES];
//}
//
#pragma mark - UIViewControllerTransitioningDelegate
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    HYBrowserPresentationController *controller = [[HYBrowserPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    return controller;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    // Present Half
    AnimatorPresentZoomTransition *presentZoomTransition = [[AnimatorPresentZoomTransition alloc] init];
    presentZoomTransition.animatorTransitionType = kAnimatorTransitionTypeDismiss;
    [self loadDelegateDataWithTransition:presentZoomTransition];
    return presentZoomTransition;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    // Present Half
    AnimatorPresentZoomTransition *presentZoomTransition = [[AnimatorPresentZoomTransition alloc] init];
    presentZoomTransition.animatorTransitionType = kAnimatorTransitionTypePresent;
    [self loadDelegateDataWithTransition:presentZoomTransition];
    return presentZoomTransition;
}
#pragma mark - 获取代理数据
-(void)loadDelegateDataWithTransition: (AnimatorPresentZoomTransition *)transition{
    if ([self.browserDelegate respondsToSelector:@selector(imageForBrowserWillShow:)]) {
        transition.image = [self.browserDelegate imageForBrowserWillShow: self];
    }
    if ([self.browserDelegate respondsToSelector:@selector(browserControllerWillShowToFrame:)]) {
        transition.toFrame = [self.browserDelegate browserControllerWillShowToFrame: self];
    }
    if ([self.browserDelegate respondsToSelector:@selector(browserControllerWillShowFromFrame:)]) {
        transition.fromFrame = [self.browserDelegate browserControllerWillShowFromFrame: self];
    }


}


@end
