//
//  HYShopCartTool.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/17.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYShopCartTool.h"
#import "HYGoods.h"
#import "NSString+Extension.h"

@interface HYShopCartTool ()

@end

@implementation HYShopCartTool
//singleton
static HYShopCartTool *_instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+(instancetype)sharedCartTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
-(id)copyWithZone:(struct _NSZone *)zone{
    return _instance;
}
#pragma mark - methods

- (NSMutableArray<HYGoods *> *)shopCarGoods
{
    if (!_shopCarGoods) {
        _shopCarGoods = [NSMutableArray array];
    }
    return  _shopCarGoods;
}

#pragma 添加商品
- (void)addSupermarkProductToShopCar:(HYGoods *)goods {
    
    
    for (HYGoods *obj in self.shopCarGoods) {
        if (obj.gid == goods.gid) {
            return;
        }
    }
    [self.shopCarGoods addObject:goods];
}
-(void) addSupermarkProductToShopCarWithGoods:(HYGoods *)goods WithNumber:(NSUInteger)number{
    [self addSupermarkProductToShopCar:goods];
    goods.userBuyNumber = number;
}
#pragma 删除商品
- (void)removeFromProductShopCar:(HYGoods *)goods {
    for (HYGoods *obj in self.shopCarGoods) {
        if (goods.gid == obj.gid) {
            [self.shopCarGoods removeObject:goods];
            obj.userBuyNumber = 0;
            [[NSNotificationCenter defaultCenter] postNotificationName:HYShopCartRemoveProductNofitication object:self userInfo:nil];
            return ;
        }
    }
}
-(void)removeAllProducts{
    for (HYGoods *obj in self.shopCarGoods) {
        obj.userBuyNumber = 0;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:HYShopCartRemoveProductNofitication object:self userInfo:nil];
    [self.shopCarGoods removeAllObjects];
}
#pragma 获取商品的数量
- (NSInteger)getShopCarGoodsNumber {
    __block NSInteger count = 0;
    [self.shopCarGoods enumerateObjectsUsingBlock:^(HYGoods * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        count += obj.userBuyNumber;
    }];
    return count;
}
#pragma 获取商品用价格
- (CGFloat)getShopCarGoodsPrice {
    __block CGFloat price = 0;
    [self.shopCarGoods enumerateObjectsUsingBlock:^(HYGoods *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        price += [[obj.price cleanDecimalPointZear] doubleValue] * obj.userBuyNumber;
    }];
    return price;
}
- (BOOL)isEmpty {
    return self.shopCarGoods.count == 0;
}




@end
