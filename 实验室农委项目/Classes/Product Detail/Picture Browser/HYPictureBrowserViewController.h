//
//  HYPictureBrowserViewController.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/9.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^pictureBrowserCallBack)(UIButton *button, NSUInteger index);

@interface HYPictureBrowserViewController : UIViewController
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, copy) pictureBrowserCallBack closeBtnClickCallBack;
@property (nonatomic, assign) int index;

-(instancetype)initWithImageArray: (NSArray *)imageArray index:(int)index;

@end
