//
//  HYBrowserViewLayout.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/9.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYBrowserViewLayout.h"

@implementation HYBrowserViewLayout
-(instancetype)init{
    if ((self = [super init])) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])) {
        [self setup];
    }
    return self;
}
-(void)setup{
    self.itemSize = [UIScreen mainScreen].bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.collectionView setPagingEnabled:YES];
    self.collectionView.bounces = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

@end
