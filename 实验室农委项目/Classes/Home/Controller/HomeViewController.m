//
//  HomeViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/6.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HomeViewController.h"
#import "HYPageView.h"
#import "HYHomeHeaderView.h"
#import "QRCodeViewController.h"
#import "HYDetailCell.h"
#import "HYTypeModel.h"
#import "HYDetailModel.h"
#import "HYListViewController.h"
#import <Masonry/Masonry.h>
#import "UIImage+Fit.h"
#import "PYSearch.h"
#import "HYGoods.h"
#import <MJRefresh/MJRefresh.h>
#import "HYGoodsViewModel.h"

#define TopCount 3
//#define bannerHeight 240
#define botCellIdentifier @"botCell"
#define botHeaderIdentifier @"botHeader"
#define collectionViewMargin 20



@interface HomeViewController ()<HYPageViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, PYSearchViewControllerDelegate>
@property (nonatomic, strong) HYPageView *topBanner;
@property (nonatomic, strong) NSArray *topImages;
//@property (nonatomic, strong) UISearchBar *middleBar;
@property (nonatomic, strong) UICollectionView *botCollectionView;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) HYSuperMarketData *SMData;
@property (nonatomic, assign) CGFloat bannerHeight;

@end


@implementation HomeViewController

#pragma mark - 懒加载

-(HYSuperMarketData *)SMData{
    if (!_SMData) {
        _SMData = [[HYGoodsViewModel sharedGoodsViewModel] loadGoods];
    }
    return _SMData;
}

-(NSArray *)typeArray{
    if (!_typeArray) {
        NSMutableArray *arr = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Homelist.plist" ofType:nil];
        NSArray *a  = [NSArray arrayWithContentsOfFile:path];
        for(NSDictionary *dict in a){
            HYTypeModel *type = [HYTypeModel typeModelWithDict:dict];
            [arr addObject:type];
        }
        _typeArray = [arr copy];
        
    }
    return _typeArray;
}

-(NSArray *)topImages{
    if (!_topImages) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < TopCount; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"rec%d",i+1]];
            [array addObject:image];
        }
        _topImages = [array copy];
    }
    return _topImages;
}

-(HYPageView *)topBanner{
    if (!_topBanner) {
//        _topBanner = [[HYPageView alloc] initPageViewWithFrame: CGRectMake(0, 64, WIDTH, bannerHeight) Views:self.topImages];
        UIImage *image = self.topImages[0];
        CGFloat scale = image.size.height / image.size.width;
         _bannerHeight = screenWidth * scale;
        _topBanner = [[HYPageView alloc] initWithFrame: CGRectMake(0, -_bannerHeight, screenWidth, _bannerHeight)];
        _topBanner.imageArr = self.topImages;
        _topBanner.delegate = self;
    }
    return _topBanner;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;//必须要加上这句，否则scrollview会自带inset
    [self createSearchBtn];
    self.navigationController.navigationBar.tintColor = tColor;
    [self createBotCollectionView];
    [self createScanBtn];
//    self.navigationController.navigationBar.translucent = YES;
    
}


#pragma mark - createItems


//ScanButton
-(void)createScanBtn{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_black_scancode"] style:UIBarButtonItemStylePlain target:self action:@selector(scanBtnClick)];
    self.navigationItem.rightBarButtonItem = item;
}

/*searchBtn*/
-(void)createSearchBtn{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnClick)];
    self.navigationItem.leftBarButtonItem = item;
}

/*collectionView*/
-(void)createBotCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//    cv.backgroundColor = [UIColor clearColor];
    cv.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0f];
    [self.view addSubview:cv];
    [cv addSubview: self.topBanner];

    cv.contentInset = UIEdgeInsetsMake(_bannerHeight, 0, tabbarHeight, 0);
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [cv registerClass:[HYDetailCell class] forCellWithReuseIdentifier:botCellIdentifier];
    [cv registerClass:[HYHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:botHeaderIdentifier];
    cv.dataSource = self;
    cv.delegate = self;
    self.botCollectionView = cv;
    __weak __typeof(self) weakSelf = self;
    
    _botCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.b reloadData];
            //刷新数据
            [self reloadData];
            // 结束刷新
            [weakSelf.botCollectionView.mj_header endRefreshing];

        });
        
    }];
    [_botCollectionView.mj_header beginRefreshing];
    // 布局 layout

    
    flowLayout.itemSize = [self getItemSize];
    flowLayout.minimumLineSpacing = collectionViewMargin;
    flowLayout.minimumInteritemSpacing = collectionViewMargin;
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 10);
    
    flowLayout.headerReferenceSize  = CGSizeMake(screenWidth, 30);
    
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    HYListViewController *listVc = [[HYListViewController alloc] init];
//    listVc.searchStr = model.name;
    ProductCategory *category = [self.SMData.categories objectAtIndex:indexPath.section];
    ProductChildCategory *childCategory = [category.childCategories objectAtIndex:indexPath.item];
    listVc.products = childCategory.products;
    [self.navigationController pushViewController:listVc animated:YES];
}

#pragma mark - UICollectionViewDataSource

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HYHomeHeaderView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
//        if (indexPath.section == 0) {
//            HYHomeHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"banner" forIndexPath:indexPath];
//            reusableView = header;
//        }else{
            HYHomeHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:botHeaderIdentifier forIndexPath:indexPath];
            reusableView = header;
            reusableView.model = self.SMData.categories[indexPath.section];
        
    }
//    reusableView.backgroundColor = [UIColor clearColor];
    return reusableView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.SMData.categories.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    ProductCategory *category = self.SMData.categories[section];
    return category.childCategories.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HYDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:botCellIdentifier forIndexPath:indexPath];
//    HYTypeModel *m = self.typeArray[indexPath.section];
    ProductCategory *category = self.SMData.categories[indexPath.section];
    cell.model = category.childCategories[indexPath.row];
    return cell;
}
#pragma mark - UIScrollViewDelegate




#pragma mark - HYPageViewDelegate
-(void)pageViewDidClickAtPageNumber:(NSUInteger)index{
    DLog(@"%lu", (unsigned long)index);
}

#pragma mark - PYSearchViewControllerDelegate

- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜索完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}


#pragma mark - 内部控制方法
//加载数据
-(void)reloadData{
    [self.botCollectionView reloadData];
}

//-(void)loadData{
//    self.SMData = [[HYGoodsViewModel sharedGoodsViewModel] loadGoods];
//}

-(void)scanBtnClick{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"QRCode" bundle:nil];
    QRCodeViewController *vc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)searchBtnClick{
    NSArray *hotSeaches = @[@"苹果", @"毛冬瓜", @"进口蓝莓", @"香蕉", @"北京白菜", @"秋葵", @"枇杷", @"西兰花", @"鸡腿", @"澳洲进口雪花牛腩块", @"川香鸡柳", @"优质肘子", @"黑美人西瓜", @"经典鸡块"];
    // 2. Create searchViewController
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入搜索商品" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // Call this Block when completion search automatically
        // Such as: Push to a view controller
        HYListViewController *listVc = [[HYListViewController alloc] init];
//        listVc.searchStr = searchBar.text;
        [searchViewController.navigationController pushViewController:listVc animated:YES];
    }];
    //2.5 setup
    //    searchViewController.navigationController.navigationBar.tintColor = tColor;
    searchViewController.hotSearchStyle = PYHotSearchStyleRankTag;
    searchViewController.delegate = self;
    // 3. present the searchViewController
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    nav.navigationBar.tintColor = tColor;
    [self presentViewController:nav  animated:YES completion:nil];

}
-(CGSize)getItemSize{
    NSString *imgName = [[[[self.SMData.categories firstObject] childCategories] firstObject] img];
    UIImage *img = [UIImage imageNamed:imgName];
    CGFloat imageW = img.size.width;
    CGFloat imageH = img.size.height;
    CGFloat scale = imageH / imageW;
    CGFloat width = (screenWidth - collectionViewMargin * 3) * 0.5;
    CGFloat height = width * scale;
    return CGSizeMake(width, height);
    
}

-(UIImage *)getImageWithColor: (UIColor *)color height:(CGFloat)height{
    CGRect r = CGRectMake(0, 0, 1, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
