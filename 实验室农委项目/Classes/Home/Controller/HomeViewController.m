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
#import "HYDetailCell.h"
#import "HYTypeModel.h"
#import "HYDetailModel.h"
#import "HYListViewController.h"
#import <Masonry/Masonry.h>



#define TopCount 6
#define bannerHeight 240
#define botCellIdentifier @"botCell"
#define botHeaderIdentifier @"botHeader"


@interface HomeViewController ()<HYPageViewDelegate, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) HYPageView *topBanner;
@property (nonatomic, strong) NSArray *topImages;
@property (nonatomic, strong) UISearchBar *middleBar;
@property (nonatomic, strong) UICollectionView *botCollectionView;
@property (nonatomic, strong) NSArray *typeArray;

@end

@implementation HomeViewController

#pragma mark - 懒加载

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
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
            [array addObject:image];
        }
        _topImages = [array copy];
    }
    return _topImages;
}

-(HYPageView *)topBanner{
    if (!_topBanner) {
//        _topBanner = [[HYPageView alloc] initPageViewWithFrame: CGRectMake(0, 64, WIDTH, bannerHeight) Views:self.topImages];
        _topBanner = [[HYPageView alloc] initWithFrame: CGRectMake(0, 64, WIDTH, bannerHeight)];
        _topBanner.imageArr = self.topImages;
        _topBanner.delegate = self;
    }
    return _topBanner;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.topBanner];
    self.automaticallyAdjustsScrollViewInsets = NO;//必须要加上这句，否则scrollview会自带inset
    [self createSearchBar];
    self.navigationController.navigationBar.tintColor = tColor;
    [self createBotCollectionView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    UIView *cover = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [cover setBackgroundColor:[UIColor whiteColor]];
    [cover setAlpha:0.02];
    self.middleBar.inputAccessoryView = cover;
    [cover addGestureRecognizer:tap];
//    [self.topBanner addGestureRecognizer:tap];
//    [self.botCollectionView addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - createItems

/*searchbar*/
-(void)createSearchBar{

    UIView *superview = self.view;
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    self.middleBar = searchBar;
//    searchBar.frame = CGRectMake(0, TOPPH + self.topBanner.height, WIDTH, ConsHeight);
    [self.view addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(superview.mas_left);
        make.right.mas_equalTo(superview.mas_right);
        make.top.mas_equalTo(self.topBanner.mas_bottom);
        make.height.mas_equalTo(ConsHeight);
    }];
    searchBar.barStyle = UISearchBarStyleDefault;
    searchBar.placeholder = @"请输入需要的农产品...";
//    searchBar.barTintColor = [UIColor colorWithRed:235.f/255 green:235.f/255 blue:241.f/255 alpha:1.0];
    searchBar.delegate = self;
    searchBar.keyboardType = UIKeyboardTypeDefault;
//    searchBar.showsCancelButton = YES;
    //获取cancel button
//    UIButton *cancelBtn = [searchBar valueForKey:@"_cancelButton"];
//    [cancelBtn setTitle:@"搜索" forState:normal];
//    [cancelBtn setTitleColor:tColor forState:UIControlStateNormal];
//    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [searchBar setBackgroundImage:[UIImage new]];
    [searchBar setContentMode:UIViewContentModeLeft];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = tColor;
//    bottomLine.frame = CGRectMake(0, ConsHeight - 2, WIDTH, 2);
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = tColor;
    [searchBar addSubview:bottomLine];
    [searchBar addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH);
        make.height.mas_equalTo(2);
        make.left.mas_equalTo(superview.mas_left);
        make.right.mas_equalTo(superview.mas_right);
        make.top.mas_equalTo(searchBar.mas_top);
    }];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH);
        make.height.mas_equalTo(2);
        make.left.mas_equalTo(superview.mas_left);
        make.right.mas_equalTo(superview.mas_right);
        make.bottom.mas_equalTo(searchBar.mas_bottom);
    }];
    
    

}
/*collectionView*/
-(void)createBotCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    CGFloat y = bannerHeight + ConsHeight + 64;
//    CGFloat height = [UIScreen mainScreen].bounds.size.height - y;
//    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0 , WID0H, height - 44) collectionViewLayout:flowLayout];
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    cv.backgroundColor = [UIColor clearColor];
    [self.view addSubview:cv];
    UIView *superview = self.view;
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(WIDTH);
        make.top.mas_equalTo(self.middleBar.mas_bottom);
        make.bottom.mas_equalTo(superview.mas_bottom).offset(-44);
        make.left.mas_equalTo(superview.mas_left);
        make.right.mas_equalTo(superview.mas_right);
    }];
    [cv registerClass:[HYDetailCell class] forCellWithReuseIdentifier:botCellIdentifier];
    [cv registerClass:[HYHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:botHeaderIdentifier];
    cv.dataSource = self;
    cv.delegate = self;
    
    // 布局 layout
    flowLayout.itemSize = CGSizeMake(100, 100);
    flowLayout.minimumLineSpacing = 30;
    flowLayout.minimumInteritemSpacing = 10;
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    flowLayout.headerReferenceSize  = CGSizeMake(WIDTH, 40);
    
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HYTypeModel *type = self.typeArray[indexPath.section];
    HYDetailModel *model = type.detailList[indexPath.item];
    
    DLog(@"%@, %@", model.name, type.title);
    HYListViewController *listVc = [[HYListViewController alloc] init];
    listVc.searchStr = model.name;
    [self.navigationController pushViewController:listVc animated:NO];
}

#pragma mark - UICollectionViewDataSource

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HYHomeHeaderView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        HYHomeHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:botHeaderIdentifier forIndexPath:indexPath];
        reusableView = header;
        
        reusableView.model = self.typeArray[indexPath.section];
    }
//    reusableView.backgroundColor = [UIColor clearColor];
    return reusableView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.typeArray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.typeArray[section] detailList].count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HYDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:botCellIdentifier forIndexPath:indexPath];
    HYTypeModel *m = self.typeArray[indexPath.section];
    cell.model = m.detailList[indexPath.item];
    return cell;
}



#pragma mark - HYPageViewDelegate
-(void)pageViewDidClickAtPageNumber:(NSUInteger)index{
    DLog(@"%lu", (unsigned long)index);
}

#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    DLog(@"%@", searchBar.text);
    [self.middleBar resignFirstResponder];
    HYListViewController *listVc = [[HYListViewController alloc] init];
    listVc.searchStr = searchBar.text;
    [self.navigationController pushViewController:listVc animated:NO];

}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    DLog(@"%@", searchBar.text);
    searchBar.text = @"";
    [self.middleBar resignFirstResponder];
    HYListViewController *listVc = [[HYListViewController alloc] init];
    listVc.searchStr = searchBar.text;
    [self.navigationController pushViewController:listVc animated:NO];

}
#pragma mark - 内部控制方法
-(void)dismissKeyboard{
    [self.middleBar resignFirstResponder];
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
