//
//  HYOrderListView.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/28.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYOrderListView : UIView
-(instancetype)initWithOrderLists:(NSArray *)lists;
-(void)reloadData;
@end
