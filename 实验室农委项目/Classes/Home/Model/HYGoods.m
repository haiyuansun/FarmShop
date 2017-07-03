//
//  HYGoods.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/13.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYGoods.h"
#import "NSString+Extension.h"
#import <MJExtension/MJExtension.h>

@implementation HYSupermarketSource

+ (void)loadSupermarketData:(CompleteBlock)complete {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"myGoods" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    HYSupermarketSource *source = [HYSupermarketSource mj_objectWithKeyValues:json];
    HYSuperMarketData *superMarketData = source.data;
    NSMutableArray *M_Array = [NSMutableArray array];
    for (NSInteger i = 0; i < superMarketData.categories.count; i++) {
        ProductCategory *category = superMarketData.categories[i];
        NSArray *productsArr = superMarketData.products[category.id];
        NSArray *products = [HYGoods mj_objectArrayWithKeyValuesArray:productsArr];
        for(HYGoods *item in products){
            [M_Array addObject:item];
        }
        NSArray *cidArray = category.cids;
        category.childCategories = [ProductChildCategory mj_objectArrayWithKeyValuesArray:cidArray];
        for (ProductChildCategory *cate in category.childCategories) {
            //初始化一级分类下的所有商品
            NSArray *productsArr = superMarketData.products[cate.pcid];
            NSArray *products = [HYGoods mj_objectArrayWithKeyValuesArray:productsArr];
            NSMutableArray *Marray = [NSMutableArray array];
            //在一级分类的商品中通过二级分类id获取对应的商品
            for (HYGoods *product in products) {
                if (product.child_cid == cate.id) {
                    [Marray addObject:product];
                }
            }
            cate.products = [Marray copy];
        }
        
    }
    superMarketData.products = [M_Array copy];
    complete(superMarketData,nil);
}
@end


@implementation ProductChildCategory

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"childCategories":NSStringFromClass([ProductChildCategory class])};
}


@end

@implementation HYSuperMarketData

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"categories":NSStringFromClass([ProductCategory class])};
}


@end


@implementation ProductCategory


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"products":NSStringFromClass([HYGoods class])};
}

@end


@implementation HYGoods

-(void)setPrice:(NSString *)price{
    _price = [price stringToDoubleDecimal];
}
-(void)setPartner_price:(NSString *)partner_price{
    _partner_price = [partner_price stringToDoubleDecimal];
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"gid" : @"id"};
}
@end
