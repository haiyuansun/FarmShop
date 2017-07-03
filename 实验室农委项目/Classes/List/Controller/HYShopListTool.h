//
//  HYShopListTool.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/27.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HYShopList, HYGoods;

@interface HYShopListTool : NSObject
+(instancetype)sharedListTool;

-(void)userCreateListWithItem:(HYGoods *)item;

-(void)userCreateListWithItems:(NSArray *)items andTotalCost:(CGFloat)cost;

-(NSArray *)getUserLists;

@end
