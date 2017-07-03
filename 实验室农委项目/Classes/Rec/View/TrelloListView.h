//
//  TrelloListView.h
//  SCTrelloNavigation
//
//  Created by Yh c on 15/11/5.
//  Copyright © 2015年 Yh c. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTrelloHeader.h"
#import "TrelloListItem.h"
#import "TrelloListTableView.h"
#import "TrelloListIconView.h"
#import "TrelloListTableViewCell.h"
#import "TrelloListCellItem.h"
@class TrelloListView;
@protocol TrelloListViewDelegate<NSObject>

@optional
-(void)trelloListView:(TrelloListView *)listView didSelectAtCellItem: (TrelloListCellItem *)item;

@end


@interface TrelloListView : UIScrollView <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate, TrelloListViewDelegate>

@property (strong, nonatomic) NSMutableArray *reusableTableViewArray;
@property (strong, nonatomic) NSMutableArray *visibleTableViewArray;

@property (strong, nonatomic) TrelloListTableView *tableView;

@property (strong,nonatomic) NSMutableArray *listItems;
@property (nonatomic) NSInteger currentIndex;

@property (nonatomic) CGFloat originTop;
@property (nonatomic) BOOL isFoldMode;

@property (copy) void (^HeaderDidFoldedCallBack)();


- (id)initWithFrame:(CGRect)frame index:(NSInteger)index listArray:(NSArray *)listItems;
- (void)reloadData;
@end

@interface TrelloListView()

@property (nonatomic, weak) id<TrelloListViewDelegate> delegate;
@end
