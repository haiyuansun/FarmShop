//
//  HYShopCartCell.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/13.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopCartCellItemSelectedBlock)(BOOL isSelected);

@class HYGoods;
@interface HYShopCartCell : UITableViewCell
@property (nonatomic, strong) HYGoods *product;
@property (nonatomic, copy) ShopCartCellItemSelectedBlock selectCallBack;

@end
