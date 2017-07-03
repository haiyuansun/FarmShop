//
//  UILabel+AdjustLabelFrame.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/10.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AdjustLabelFrame)
//+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;

@end
