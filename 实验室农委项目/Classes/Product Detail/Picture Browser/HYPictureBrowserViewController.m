//
//  HYPictureBrowserViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/9.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYPictureBrowserViewController.h"
#import "HYBrowserViewLayout.h"
#import "HYBrowserViewCell.h"
#import <Masonry/Masonry.h>
#define browserIdentifier @"browser"

@interface HYPictureBrowserViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation HYPictureBrowserViewController

#pragma mark - init
-(instancetype)initWithImageArray:(NSArray *)imageArray index:(NSUInteger)index{
    if (self = [super init]) {
        self.imageArray = imageArray;
        self.index = index;
    }
    return self;
}

#pragma mark - 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[HYBrowserViewLayout alloc] init]];
        cv.dataSource = self;
        cv.delegate = self;
        cv.pagingEnabled = YES;
        cv.showsHorizontalScrollIndicator = NO;
        [cv registerClass:[HYBrowserViewCell class] forCellWithReuseIdentifier:browserIdentifier];
        cv.backgroundColor = [UIColor clearColor];
        _collectionView = cv;
    }
    
    return _collectionView;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        UIButton *btn = [[UIButton alloc] init];
//        [btn setTitle:@"关闭" forState:normal];
        
//        btn.alpha = 0.8;
        [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
//        btn.titleLabel.textColor = [UIColor blackColor];
        [btn addTarget:self action:@selector(clostBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn = btn;
    }
    return _closeBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    DLog("%d", self.index);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}
#pragma mark - setup UI
-(void)setupUI{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.closeBtn];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.bottom.mas_equalTo(self.view).offset(-30);
        make.centerX.mas_equalTo(self.view);
    }];

    
}
#pragma mark - methods
-(void)clostBtnOnClick:(UIButton *)btn{
    self.index = [self.collectionView.indexPathsForVisibleItems lastObject].item;
    self.closeBtnClickCallBack(btn, self.index);
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectiomViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HYBrowserViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:browserIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.image = self.imageArray[indexPath.item];
    return cell;
}
@end

