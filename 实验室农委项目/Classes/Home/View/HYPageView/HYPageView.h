//
//  HYCollectionView.h
//  轮播图
//
//  Created by 孙海源 on 2017/3/6.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HYPageViewDelegate <NSObject>

@optional
-(void)pageViewDidClickAtPageNumber: (NSUInteger)index;

@end

@interface HYPageView : UIView
//-(instancetype)initPageViewWithFrame: (CGRect)frame Views:(NSArray *)views;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, assign) id<HYPageViewDelegate> delegate;
@end
