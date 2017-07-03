//
//  HYDetailViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/8.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYDetailViewController.h"
#import "HYPageView.h"
#import "HYPictureBrowserViewController.h"
#import "HYBotPriceView.h"
#import <Masonry/Masonry.h>
#import "UIView+AdjustFrame.h"
#import "UIImageView+AspectFitImage.h"
#import "HYCommentView.h"
#import "HMSegmentedControl.h"
#import "HYBrowserPresentationController.h"
#import "HYSelectViewController.h"
#import "HYSelectViewPresentationController.h"
#import "ShopCartViewController.h"

@interface HYDetailViewController ()<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate,
CAAnimationDelegate,
HYBrowserPresentationControllerDelegate
>
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) HMSegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (nonatomic, strong) UIView *recordView;
@property (nonatomic, strong) HYBotPriceView *bottomView;
@property (nonatomic, strong) UIImage *detailImage;
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UIImageView *detailedView;
@property (nonatomic, strong) HYBrowserPresentationController *browserPresentationController;
@property (nonatomic, strong) HYSelectViewPresentationController *selectViewPresentationController;
@property (nonatomic, assign) NSUInteger pictureBrowserIndex;
@property (weak, nonatomic) IBOutlet UILabel *productNameLb;
@end

@implementation HYDetailViewController
#pragma mark -懒加载
//-(HYBrowserPresentationController *)browserPresentationController{
//    if (!_browserPresentationController) {
//        _browserPresentationController = [HYBrowserPresentationController new];
//    }
//    return _browserPresentationController;
//}

-(UIImage *)detailImage{
    if (!_detailImage) {
        UIImage *im = [UIImage imageNamed:@"青柠檬介绍"];
        _detailImage = im;
    }
    return _detailImage;
}
-(NSArray *)images{
    if (!_images) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"柠檬%d",i+1]];
            [array addObject:image];
        }
        _images = [array copy];
    }
    return _images;
}
-(HYBotPriceView *)bottomView{
    if (!_bottomView) {
        HYBotPriceView *view = [[HYBotPriceView alloc] initWithPrice:[self.product.price doubleValue]];
        DLog("%f", [self.product.price doubleValue]);
        _bottomView = view;
    }
    return _bottomView;
}


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.pictureBrowserIndex = 0;
    });
    //只执行一次
//    [self.detailedView sizeToFit];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.detailImage];
//    [self.detailScrollView addSubview:imageView];
//    
//    self.detailScrollView.size = self.detailImage.size;
//    imageView.frame = CGRectMake(0, 0, WIDTH, self.detailImage.size.height);
//    self.detailScrollView.contentSize = self.detailImage.size;
//    self.detailImageView = imageView;
//    self.detailImageView.userInteractionEnabled = YES;
//    [self animationShouldBegin];
    
    [self setupUI];
//    [self setupNotification];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
        self.tabBarController.tabBar.hidden = NO;
}

//setupNotificationm
-(void)setupNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(animationShouldBegin) name:HYShopCartBuyNumberDidChangeNofitication object:nil];
}

-(void)setupUI{
    UITableView *tbv = self.tableView;
    UIView *containerView = [[UIView alloc] initWithFrame:self.view.frame];
    tbv.frame = tbv.bounds;
    self.view = containerView;
    [self.view addSubview:tbv];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.productNameLb.text = self.product.name;
    [self initSegmentControll];
    [self initTopView];
    [self initBotView];
    [self setupDetailImageView];
    [self setupIconBtn];
    self.recordView = self.view;
    self.tabBarController.tabBar.hidden = YES;
    // cart icon

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Cart-Icon"] style:UIBarButtonItemStylePlain target:self action:@selector(cartBtnClick)];
    self.navigationItem.rightBarButtonItem = item;
//    self.navigationItem.rightBarButtonItem.badgeValue = @"10";
    //    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
//    [self.navigationController.navigationItem.backBarButtonItem setTintColor:tColor];
//    [self.navigationController.navigationItem.backBarButtonItem setTitle:@"返回"];
//    [self.navigationController.navigationBar setBarTintColor:tColor];
}

#pragma mark - setup Methods
-(void)setupIconBtn{
    self.iconButton.layer.masksToBounds = YES;
    [self.iconButton.layer setCornerRadius:30.f];
    [self.iconButton.layer setBorderWidth:2.5f];
    [self.iconButton.layer setBorderColor: [UIColor colorWithRed:10.f/255.0 green:166.f/255.0 blue: 118/225.f alpha:1.0f].CGColor];
}

-(void)setupDetailImageView{
    self.detailedView.image = self.detailImage;
    CGSize rescaledSize = [self getScaleImageSizeWithImage:self.detailImage];
    
    self.detailedView.frame = CGRectMake(0, 0, rescaledSize.width, rescaledSize.height);
}

-(void)initBotView{
    [self.view addSubview:self.bottomView];
    __weak __typeof(self) weakSelf = self;

    //通过回调函数响应点击事件
    
    self.bottomView.buyBtnCallBackBlock = ^(UIButton *button){
//        DLog(@"buyBtnCallBackBlock");
        HYSelectViewController *vc = [[HYSelectViewController alloc] init];
        if(!weakSelf.selectViewPresentationController){
            _selectViewPresentationController = [[HYSelectViewPresentationController alloc] initWithPresentedViewController:weakSelf presentingViewController:vc];
    }
    vc.product = weakSelf.product;
    vc.transitioningDelegate = weakSelf.selectViewPresentationController;
    [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(80);
//        make.centerY.mas_equalTo(200);
    }];
}

-(void)initTopView{
    self.topImageView.image = [self.images firstObject];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topViewOnClick)];
    [self.topImageView addGestureRecognizer:tap];
}

-(void)initSegmentControll{
//    NSArray *segmentArr = [NSArray arrayWithObjects:@"商品", @"详情",@"评价",nil];
//    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems: segmentArr];
    HMSegmentedControl *sc = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"商品", @"详情", @"评论"]];
    sc.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    sc.tintColor = tColor;
    [sc addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    sc.selectedSegmentIndex = 0;
    sc.backgroundColor = [UIColor clearColor];
    sc.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.f]};
//    sc.selectionStyle = HMSegmentedControlSelectionStyleBox;
    sc.selectionIndicatorColor = tColor;
    self.segment = sc;
    sc.frame = CGRectMake(10, 10, 200, 30);
    self.navigationItem.titleView = sc;

}
#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tag == 0){
        if (indexPath.row == 0) {
            return 250;
        }else if (indexPath.row == 1){
            return 90;
        }else if (indexPath.row == 2){
            return [self getScaleImageSizeWithImage:self.detailImage].height;
        }
    }
    return 0;
}


#pragma mark - internal methods
-(void)animationShouldBegin{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location"]];
    iv.frame = CGRectMake(300, 600, 20, 20);
    iv.tintColor = tColor;
    [self.view addSubview:iv];
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(230, -20, 300, 600)];
//    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(300, 600)];
//    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(280, 500)];
//    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(260, 400)];
//    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(250, 300)];
//    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(270, 200)];
//    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(280, 100)];
//    NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake(330, 10)];
    
//    keyFrameAnimation.values = @[value0,value1,value2,value3,value4,value5,value6];
    keyFrameAnimation.path = bezierPath.CGPath;
    keyFrameAnimation.duration = 2.0;
    keyFrameAnimation.delegate = self;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [iv.layer addAnimation:keyFrameAnimation forKey:@"keyFrameAnimation"];
}


//click action
- (IBAction)iconBtnClick:(UIButton *)sender {
    DLog(@"...");
}

-(void)cartBtnClick{
    DLog(@"..");
//    ShopCartViewController *vc = [[ShopCartViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    self.tabBarController.selectedIndex = 2;
}



-(void)topViewOnClick{
//    DLog(@"....");
    HYPictureBrowserViewController *vc = [[HYPictureBrowserViewController alloc] initWithImageArray:self.images index:self.pictureBrowserIndex];
    if (!self.browserPresentationController) {
        HYBrowserPresentationController *presentationController = [[HYBrowserPresentationController alloc] initWithPresentedViewController:self presentingViewController:vc];
        presentationController.browserDelegate = self;
        self.browserPresentationController = presentationController;
    }
    vc.transitioningDelegate = self.browserPresentationController;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.closeBtnClickCallBack = ^(UIButton *btn, NSUInteger index){
        self.topImageView.image = self.images[index];
        self.pictureBrowserIndex = index;
    };
    [self presentViewController:vc animated:YES completion:nil];
}

// segment change
-(void)segmentChanged: (UISegmentedControl *)segment{
    DLog(@"%ld", (long)segment.selectedSegmentIndex);
//    UIView *currentView = self.view;
    if (segment.selectedSegmentIndex == 1) {
        UIView *view = [[UIView alloc] initWithFrame: [UIScreen mainScreen].bounds];
        view.backgroundColor = [UIColor purpleColor];
        self.view = view;
    }else if (segment.selectedSegmentIndex ==0){
        self.view = self.recordView;
    }else if(segment.selectedSegmentIndex == 2){
//        CGFloat y = 64.f;
        HYCommentView *tb = [[HYCommentView alloc] initWithFrame: CGRectMake(0, 0, screenWidth, screenHeight)];
        self.view = tb;
    }
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

- (CGSize)getScaleImageSizeWithImage:(UIImage *)image {
    CGFloat imageH = image.size.height;
    CGFloat imageW = image.size.width;
    CGFloat scale = imageH / imageW;
    CGFloat newW = [UIScreen mainScreen].bounds.size.width;
    CGFloat newH = newW * scale;
    return CGSizeMake(newW, newH);
}
#pragma mark - HYBrowserPresentationControllerDelegate
-(CGRect)browserControllerWillShowToFrame:(HYBrowserPresentationController *)browsePresentationController{
    UIImage *image = [self.images firstObject];
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    CGFloat scale = imageH / imageW;
    CGFloat height = screenWidth * scale;
    CGFloat offsetY = (screenHeight - height) * 0.5;
    return CGRectMake(0, offsetY, screenWidth, height);
}
-(CGRect)browserControllerWillShowFromFrame:(HYBrowserPresentationController *)browsePresentationController{
    UIImageView *iv = self.topImageView;
    //设置坐标轴转换，调用者必须是所需要转换控件的superview。
    return [self.view convertRect:iv.frame toCoordinateSpace:[UIApplication sharedApplication].keyWindow];
}
//-(NSArray *)imageForBrowserWillShow:(HYBrowserPresentationController *)browsePresentationController{
//    return self.images;
//}
-(UIImage *)imageForBrowserWillShow:(HYBrowserPresentationController *)browsePresentationController{
    return self.topImageView.image;
}




@end
