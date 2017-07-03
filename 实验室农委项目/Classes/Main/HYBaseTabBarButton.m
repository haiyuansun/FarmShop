//
//  HYBaseTabBarButton.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/13.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYBaseTabBarButton.h"

@implementation HYBaseTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark 设置button内部的image的范围

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.6;
    return CGRectMake(0, 2, imageW, imageH);
}

#pragma mark 设置button内部的title的范围

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}
- (void)setHighlighted:(BOOL)highlighted{
    
}
@end
