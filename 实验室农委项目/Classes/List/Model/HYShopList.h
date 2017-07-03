//
//  HYShopList.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/27.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HYShopCartTool,HYGoods;

@interface HYShopList : NSObject

@property (nonatomic, strong) NSArray *userBuyProducts;
//@property (nonatomic, assign) CGFloat listCost;

-(instancetype)initWithItems:(NSArray *)products andTotalCost:(CGFloat)cost;

-(instancetype)initWithSingleItem: (HYGoods *)product;

@property (nonatomic, assign) CGFloat totalCost;
@property (nonatomic, copy) NSString *listId;
@property (nonatomic, copy) NSString *createTime;


@end
