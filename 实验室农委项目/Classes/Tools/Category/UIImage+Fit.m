//
//  UIImage+Fit.m
//  QQ_Zone
//
//  Created by apple on 14-12-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+Fit.h"

@implementation UIImage (Fit)

/**
 *  传入图片名称,返回拉伸好的图片
 */
+ (UIImage *)resizeImage:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] resizeImage];
}

- (UIImage *)resizeImage
{
    CGFloat width = self.size.width * 0.5;
    CGFloat height = self.size.height * 0.5;
    return [self stretchableImageWithLeftCapWidth:width topCapHeight:height];
}
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(newsize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


@end
