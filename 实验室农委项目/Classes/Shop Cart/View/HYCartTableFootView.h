//
//  AJTableFootView.h
//  loveFreshPeak
//
//  Created by ArJun on 16/8/14.
//  Copyright © 2016年 阿俊. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HYCartTableFootViewDelegate <NSObject>
- (void)didTableFootViewCommit;
@end

@interface HYCartTableFootView : UIView
@property (nonatomic, weak) id<HYCartTableFootViewDelegate>delegate ;
@property (nonatomic, assign) CGFloat sumMoney;
@end
