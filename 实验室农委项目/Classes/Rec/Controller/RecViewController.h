//
//  RecViewController.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/11.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCTrelloNavigation.h"
#import "HYBaseViewController.h"

@interface RecViewController: HYBaseViewController <UIScrollViewDelegate,TrelloDataSource, TrelloDelegate>

@property (nonatomic, strong) TrelloView *trelloView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
