//
//  AnimatorPresentZoomTransition.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/16.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "AnimatorBaseTransition.h"

@interface AnimatorPresentZoomTransition : AnimatorBaseTransition
//@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CGRect fromFrame;
@property (nonatomic, assign) CGRect toFrame;
@end
