//
//  HYLikeView.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/23.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^likeViewClickBlock)(NSUInteger index);

@interface HYLikeView : UIView
-(instancetype)initWithLikeProducts: (NSArray *)products;
@property (nonatomic, copy) likeViewClickBlock block;

@end
