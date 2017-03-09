//
//  HYDetailViewController.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/8.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYDetailViewController.h"
#import "HYPageView.h"

@interface HYDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (nonatomic, strong) UIView *recordView;
@end

@implementation HYDetailViewController
#pragma mark -懒加载
-(NSArray *)images{
    if (!_images) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
            [array addObject:image];
        }
        _images = [array copy];
    }
    return _images;
}


- (void)viewDidLoad {
    [super viewDidLoad];

//    self.pageView.imageArr = self.images;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self initSegmentControll];
    [self initTopView];
    self.recordView = self.view;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - init
-(void)initTopView{
    self.topImageView.image = [UIImage imageNamed:@"苹果"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topViewOnClick)];
    [self.topImageView addGestureRecognizer:tap];
}

-(void)initSegmentControll{
    NSArray *segmentArr = [NSArray arrayWithObjects:@"商品", @"详情",@"评价",nil];
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems: segmentArr];
    sc.tintColor = tColor;
    [sc addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
//    UIImage *image = [self getImageWithColor:[UIColor whiteColor] height:sc.height];
    sc.selectedSegmentIndex = 0;
    //        [sc setBackgroundImage:image forState:UIControlStateNormal | UIControlStateSelected barMetrics: UIBarMetricsDefault];
    sc.backgroundColor = [UIColor whiteColor];
    self.segment = sc;
    sc.frame = CGRectMake(10, 10, 200, 30);
//    [self.navigationController.navigationBar addSubview:sc];
    self.navigationItem.titleView = sc;

}

#pragma mark - Table view data source
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        NSArray *segmentArr = [NSArray arrayWithObjects:@"商品", @"详情",@"评价",nil];
//        UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems: segmentArr];
//        sc.tintColor = tColor;
//        [sc addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
//        UIImage *image = [self getImageWithColor:[UIColor whiteColor] height:sc.height];
//        sc.selectedSegmentIndex = 0;
////        [sc setBackgroundImage:image forState:UIControlStateNormal | UIControlStateSelected barMetrics: UIBarMetricsDefault];
//        sc.backgroundColor = [UIColor whiteColor];
//        return sc;
//    }
//    return nil;
//}
#pragma mark - internal methods
-(void)topViewOnClick{
    DLog(@"....");
}


-(void)segmentChanged: (UISegmentedControl *)segment{
    DLog(@"%ld", (long)segment.selectedSegmentIndex);
//    UIView *currentView = self.view;
    if (segment.selectedSegmentIndex == 1) {
        UIView *view = [[UIView alloc] initWithFrame: [UIScreen mainScreen].bounds];
        view.backgroundColor = [UIColor purpleColor];
        self.view = view;
    }else if (segment.selectedSegmentIndex ==0){
        self.view = self.recordView;
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



@end
