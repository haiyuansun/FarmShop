//
//  HYCollectionView.m
//  轮播图
//
//  Created by 孙海源 on 2017/3/6.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYPageView.h"

static const NSString *identifier = @"pool";

@interface HYPageView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation HYPageView


#pragma mark -init method

-(instancetype)initPageViewWithFrame: (CGRect)frame Views:(NSArray *)views{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArr = views;
        [self initCollectionView];
        [self createPage];
        [self createTimer];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
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
-(void)awakeFromNib{
    [super awakeFromNib];
    
}

#pragma mark -初始化控件
-(void)setup{
    [self initCollectionView];
    [self createPage];
    [self createTimer];
}

-(void)createTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollToNext) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer: self.timer forMode:NSRunLoopCommonModes];
}

-(void)createPage{
    CGFloat height = 50;
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - height, self.frame.size.width, height)];
    [self addSubview:self.page];
    self.page.numberOfPages = self.imageArr.count;
    //禁用pagecontrol交互
    self.page.userInteractionEnabled = NO;
}

-(void)initCollectionView{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    DLog("------%f, %f-------------", width, height);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width, height);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:layout];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor greenColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:50] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
//    [self.collectionView.collectionViewLayout invalidateLayout];
//    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}

#pragma mark - delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = self.frame.size.width;
    int page = (int)(scrollView.contentOffset.x / width + 0.5) % self.imageArr.count;
    self.page.currentPage = page;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self createTimer];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewDidClickAtPageNumber:)]) {
        [self.delegate pageViewDidClickAtPageNumber:indexPath.item];
    }
}


#pragma maHYCollectionViewrk - datasource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 100;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImageView *iv = [[UIImageView alloc] initWithImage:self.imageArr[indexPath.item]];
//    [cell.contentView addSubview:iv];
//    iv.frame = self.frame;
    cell.backgroundView = iv;
//    cell.image = self.imageArr[indexPath.item];
    return cell;
}

#pragma mark - 内部控制方法
-(void)scrollToNext{
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:50];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    // 设置下一个滚动的item
    NSInteger nextItem = nextIndexPath.item +1;
    NSInteger nextSection = nextIndexPath.section;
    if (nextItem==self.imageArr.count) {
        // 当item等于轮播图的总个数的时候
        // item等于0, 分区加1
        // 未达到的时候永远在50分区中
        nextItem=0;
        nextSection++;
    }
    NSIndexPath *nIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    self.page.numberOfPages = imageArr.count;
    [self layoutIfNeeded];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
