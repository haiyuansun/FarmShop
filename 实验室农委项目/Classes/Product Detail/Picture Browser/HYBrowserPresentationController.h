//
//  HYBrowserPresentationController.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/16.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBrowserPresentationController;

@protocol HYBrowserPresentationControllerDelegate <NSObject>

@optional
//to get the imageview
-(UIImage *)imageForBrowserWillShow: (HYBrowserPresentationController *)browsePresentationController;
//to get the relative frame to window
-(CGRect)browserControllerWillShowFromFrame:(HYBrowserPresentationController *)browsePresentationController;

-(CGRect)browserControllerWillShowToFrame:(HYBrowserPresentationController *)browsePresentationController;

@end

@interface HYBrowserPresentationController : UIPresentationController

@property (nonatomic, weak) id<HYBrowserPresentationControllerDelegate> browserDelegate;
@end
