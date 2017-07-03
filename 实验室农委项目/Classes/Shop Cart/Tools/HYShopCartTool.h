//
//  HYShopCartTool.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/17.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HYGoods;

@interface HYShopCartTool : NSObject
@property (nonatomic, strong) NSMutableArray <HYGoods *> *shopCarGoods;
+(instancetype)sharedCartTool;
- (void)addSupermarkProductToShopCar:(HYGoods *)goods;
- (void)removeFromProductShopCar:(HYGoods *)goods;
-(void) addSupermarkProductToShopCarWithGoods:(HYGoods *)goods WithNumber:(NSUInteger)number;
-(void)removeAllProducts;
- (CGFloat)getShopCarGoodsPrice ;
- (NSInteger)getShopCarGoodsNumber;
- (BOOL)isEmpty;


@end
