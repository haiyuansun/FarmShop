//
//  UIImageView+AspectFitImage.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/10.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "UIImageView+AspectFitImage.h"

@implementation UIImageView (AspectFitImage)
- (CGSize)intrinsicContentSize {
    
    CGSize s =[super intrinsicContentSize];
    
    s.height = self.frame.size.width / self.image.size.width  * self.image.size.height;
    
    return s;
    
}
@end
