//
//  AnimatorPresentZoomTransition.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/16.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "AnimatorPresentZoomTransition.h"
#import "HYPictureBrowserViewController.h"

@implementation AnimatorPresentZoomTransition
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    [super animateTransition:transitionContext];
}

- (void)animationPresent {

    UIView *containerView = [self.transitionContext containerView];
    UIView *toView = [self.transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [self.transitionContext viewForKey:UITransitionContextFromViewKey];

    UIImageView *iv = [[UIImageView alloc] initWithImage:self.image];
    iv.frame =self.fromFrame;
    [containerView addSubview:iv];
    iv.alpha = 0.0;
    toView.alpha = 0.0;
    fromView.alpha = 0.0;
//    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] animations:^{
//        iv.frame = self.toFrame;
//        iv.alpha = 1.0;
//    } completion:^(BOOL finished) {
//        [iv removeFromSuperview];
//        [containerView addSubview:toView];
//        BOOL wasCancelled = [self.transitionContext transitionWasCancelled];
//        [self.transitionContext completeTransition:!wasCancelled];
//        
//        
//    }];
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        iv.frame = self.toFrame;
        iv.alpha = 1.0;
        fromView.alpha = 0.0;
    } completion:^(BOOL finished) {
        toView.alpha = 1.0;
        fromView.alpha = 1.0;
        [iv removeFromSuperview];
        [containerView addSubview:toView];
        BOOL wasCancelled = [self.transitionContext transitionWasCancelled];
        [self.transitionContext completeTransition:!wasCancelled];
        
        
    }];
    
    
}

- (void)animationDismiss {
    //the reverse procedure
    UIView *containerView = [self.transitionContext containerView];
    UIView *toView = [self.transitionContext viewForKey:UITransitionContextToViewKey];
    //此处封装仍不够完整 需要继续改进
    HYPictureBrowserViewController *fromVc = (HYPictureBrowserViewController *)[self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIImageView *iv = [[UIImageView alloc] initWithImage:[self.images objectAtIndex:fromVc.index]];
    UIImageView *iv = [[UIImageView alloc] initWithImage: self.image];
    iv.frame =self.toFrame;
    [containerView addSubview:iv];
    /*
     [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
     imageView.transform = CGAffineTransformIdentity;
     imageView.center = toViewFinalCenter;
     
     self.fromView.alpha = 0.0f; // fromView 渐隐
     } completion:^(BOOL finished) {
     [imageView removeFromSuperview];
     
     weakSelf.toView.alpha = 1.0f;
     weakSelf.fromView.alpha = 1.0f;
     
     [weakSelf.transitionContext completeTransition:![weakSelf.transitionContext transitionWasCancelled]];
     }];

     */
    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        iv.frame = self.fromFrame;
        iv.alpha = 0.0;

        
    } completion:^(BOOL finished) {
        [iv removeFromSuperview];
        [containerView addSubview:toView];
        BOOL wasCancelled = [self.transitionContext transitionWasCancelled];
        [self.transitionContext completeTransition:!wasCancelled];

        
    }];
//    [UIView animateWithDuration:[self transitionDuration:self.transitionContext] animations:^{
//        iv.frame = self.fromFrame;
//        iv.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [iv removeFromSuperview];
//        [containerView addSubview:toView];
//        BOOL wasCancelled = [self.transitionContext transitionWasCancelled];
//        [self.transitionContext completeTransition:!wasCancelled];
//        
//    }];
    

}


@end
