//
//  ViewController.m
//  SCTrelloNavigation
//
//  Created by Yh c on 15/11/5.
//  Copyright © 2015年 Yh c. All rights reserved.
//

#import "RecViewController.h"
#import "UIImage+Fit.h"
#import "HYDetailViewController.h"

@implementation RecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SC_Global_trelloDeepBlue;
    
//    UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search:)];
//    search.tintColor = [UIColor whiteColor];
//    self.navigationItem.rightBarButtonItem = search;
    // Do any additional setup after loading the view, typically from a nib.
    
    [self importDataArray];
    
    // 初始化其实只要一句话的
    self.trelloView = [[TrelloView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, ScreenWidth, ScreenHeight) dataSource:self];
    [self.view addSubview:_trelloView];
    self.trelloView.delegate = self;
    //初始化tabbar item
    UIImage *image = [UIImage imageNamed:@"rec"];
    CGSize imageSize = CGSizeMake(30, 30);
    UIImage *rec = [UIImage scaleToSize:image size:imageSize];
//    [self.tabBarItem setTitle:@"test"];
    self.navigationItem.title = @"个性推荐";
    [self.navigationController.navigationBar setTintColor:tColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

//- (void)search:(id)sender
//{
//    // Test for reload data
//    //    [self.dataArray removeLastObject];
//    //    [self.trelloView reloadData];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationController.navigationBar.barTintColor = SC_Global_trelloBlue;
//    self.navigationController.navigationBar.barTintColor = [UIColor ht_greenSeaColor];
    for (UIView *view in [[[self.navigationController.navigationBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.hidden = YES;
        }
    }
    //[self.navigationController.navigationBar lt_setBackgroundColor:Global_trelloBlue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TrelloDataSource Method
- (NSInteger)numberForBoardsInTrelloView:(TrelloView *)trelloView
{
    return self.dataArray.count;
}

- (NSInteger)numberForRowsInTrelloView:(TrelloView *)trelloView atBoardIndex:(NSInteger)index
{
//    switch (index) {
//            case 0:
//            case 3:
//            return 3;
//            break;
//            case 2:
//            case 4:
//            return 2;
//            break;
//            case 1:
//            return 4;
//            break;
//        default:
//            return 0;
//            break;
//    }
    NSArray *array = self.dataArray[index];
    return array.count;
}

- (TrelloListCellItem *)itemForRowsInTrelloView:(TrelloView *)trelloView atBoardIndex:(NSInteger)index atRowIndex:(NSInteger)rowIndex;
{
    // If you want to dynamic customize your cell, you can extend the TrelloListCellItem Class to meet more requirements of your own and customize your dataArray
    return [[self.dataArray objectAtIndex:index] objectAtIndex:rowIndex];
}

- (NSString *)titleForBoardsInTrelloView:(TrelloView *)trelloView atBoardIndex:(NSInteger)index
{
    switch (index) {
            case 0:
        {
            return @"鲜果速达";
        }
            break;
            case 1:
        {
            return @"俺家时蔬";
        }
            break;
            case 2:
        {
            return @"肉蛋家禽";
        }
            break;
            case 3:
        {
            return @"进口水果";
        }
            break;
            case 4:
        {
            return @"粮油调料";
        }
            break;
        default:
            return nil;
            break;
    }
}

- (SCTrelloBoardLevel)levelForRowsInTrelloView:(TrelloView *)trelloView atBoardIndex:(NSInteger)index
{
    switch (index) {
            case 0:
            return SCTrelloBoardLevel3;
            break;
            case 3:
            return SCTrelloBoardLevel4;
            break;
            case 2:
            return SCTrelloBoardLevel2;
            break;
            case 4:
            return SCTrelloBoardLevel3;
            break;
            case 1:
            return SCTrelloBoardLevel5;
            break;
        default:
            return SCTrelloBoardLevel1;
            break;
    }
}

- (void)importDataArray
{
    TrelloListCellItem *cell_item_1_1 = [[TrelloListCellItem alloc] initWithContent:@"时令现採，基地直摘" image:[UIImage imageNamed:@"pic_rec4"] type:SCTrelloCellItemGreen boardIndex: 0];
    TrelloListCellItem *cell_item_1_2 = [[TrelloListCellItem alloc] initWithContent:@"每一粒都有自然的清香" image:[UIImage imageNamed:@"pic_rec5"] type:SCTrelloCellItemYellow boardIndex:0];
//    TrelloListCellItem *cell_item_1_3 = [[TrelloListCellItem alloc] initWithContent:@"Have a pleasant afternoon" image:[UIImage imageNamed:@"testImage3"] type:SCTrelloCellItemRed];
    
    TrelloListCellItem *cell_item_2_1 = [[TrelloListCellItem alloc] initWithContent:@"深蓝色的诱惑" image:[UIImage imageNamed:@"pic_rec1"] type:SCTrelloCellItemGreen boardIndex:1];
    TrelloListCellItem *cell_item_2_2 = [[TrelloListCellItem alloc] initWithContent:@"自然生长，新鲜采摘" image:[UIImage imageNamed:@"pic_rec2"] type:SCTrelloCellItemYellow boardIndex:1];
    TrelloListCellItem *cell_item_2_3 = [[TrelloListCellItem alloc] initWithContent:@"请持续关注我们" image:nil type:SCTrelloCellItemRed boardIndex:1];
//    TrelloListCellItem *cell_item_2_4 = [[TrelloListCellItem alloc] initWithContent:@"Displayed content is random created" image:nil type:SCTrelloCellItemYellowAndOrange];
    
    TrelloListCellItem *cell_item_3_1 = [[TrelloListCellItem alloc] initWithContent:@"Make the interface more beautiful" image:nil type:SCTrelloCellItemGreen boardIndex:2];
    TrelloListCellItem *cell_item_3_2 = [[TrelloListCellItem alloc] initWithContent:@"This feels awesome" image:[UIImage imageNamed:@"testImage2"] type:SCTrelloCellItemYellowAndOrange boardIndex:2];
    
    TrelloListCellItem *cell_item_4_1 = [[TrelloListCellItem alloc] initWithContent:@"Test this first demo" image:nil type:SCTrelloCellItemGreen boardIndex:3];
    TrelloListCellItem *cell_item_4_2 = [[TrelloListCellItem alloc] initWithContent:@"Push project to github" image:nil type:SCTrelloCellItemYellow boardIndex:3];
    TrelloListCellItem *cell_item_4_3 = [[TrelloListCellItem alloc] initWithContent:@"Have a pleasant afternoon" image:[UIImage imageNamed:@"testImage1"] type:SCTrelloCellItemRed boardIndex:3];
    
    NSMutableArray *t_array_1 = [NSMutableArray arrayWithObjects:cell_item_1_1,cell_item_1_2, nil];
    NSMutableArray *t_array_2 = [NSMutableArray arrayWithObjects:cell_item_2_1,cell_item_2_2,cell_item_2_3, nil];
    NSMutableArray *t_array_3 = [NSMutableArray arrayWithObjects:cell_item_3_1,cell_item_3_2, nil];
    NSMutableArray *t_array_4 = [NSMutableArray arrayWithObjects:cell_item_4_1,cell_item_4_2,cell_item_4_3, nil];
    
    self.dataArray = [NSMutableArray arrayWithObjects:t_array_1,t_array_2,t_array_3,t_array_4,t_array_3, nil];
}
#pragma mark - TrelloDelegate
-(void)trelloItemDidSelect:(TrelloListCellItem *)item{
    DLog(@"item content: %@", item.content);
//    [self.navigationController pushViewController:[[HYDetailViewController alloc] init] animated:YES];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HYDetailStoryboard" bundle:nil];
    HYDetailViewController *vc = [sb instantiateInitialViewController];
//    self.navigationController.navigationBar.backgroundColor = [UIColor ht_blueJeansColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.backItem.title = @"返回";
    
//    [self.navigationController.navigationItem.backBarButtonItem setTitle:@"返回"];
//    self.navigationController.navigationItem.backBarButtonItem.title = @"返回"
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];

}

@end
