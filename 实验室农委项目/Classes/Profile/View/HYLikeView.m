//
//  HYLikeView.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/23.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYLikeView.h"
#import "HYLikeCell.h"
#import <Masonry/Masonry.h>
#define HYLikeCellIdentifier @"HYLikeCellIdentifier"
@interface HYLikeView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *products;
@end

@implementation HYLikeView
-(instancetype)initWithLikeProducts: (NSArray *)products{
    if (self = [super init]) {
        _products = products;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *clv = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
    [clv registerClass:[HYLikeCell class] forCellWithReuseIdentifier:HYLikeCellIdentifier];
    clv.delegate = self;
    clv.dataSource = self;
    clv.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    flowLayout.itemSize = CGSizeMake(100, 150);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    clv.backgroundColor = [UIColor whiteColor];
    [self addSubview:clv];
    [clv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.block(indexPath.item);
}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.products.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HYLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HYLikeCellIdentifier forIndexPath:indexPath];
    cell.product = self.products[indexPath.item];
    return cell;
}

@end
