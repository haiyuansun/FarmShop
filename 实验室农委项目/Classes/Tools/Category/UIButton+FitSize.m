//
//  UIButton+FitSize.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/19.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "UIButton+FitSize.h"

@implementation UIButton (FitSize)

-(CGFloat)buttonWidthWithHeight:(CGFloat)height{
    NSString *content = self.titleLabel.text;
    UIFont *font = self.titleLabel.font;
    CGSize size = CGSizeMake(MAXFLOAT, height);
    CGSize buttonSize = [content boundingRectWithSize:size
                                              options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:@{ NSFontAttributeName:font}
                                              context:nil].size;
    return buttonSize.width;
}

@end
