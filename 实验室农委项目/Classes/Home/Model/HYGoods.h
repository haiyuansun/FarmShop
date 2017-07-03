//
//  HYGoods.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/13.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompleteBlock)(id data,NSError *error);

@class HYGoods;
@class HYSuperMarketData;
@class ProductCategory;
@class ProductChildCategory;

@interface HYSupermarketSource : NSObject

/** code  */
@property (nonatomic, copy) NSString *code;
/** msg  */
@property (nonatomic, copy) NSString *msg;
/** data  */
@property (nonatomic,strong)HYSuperMarketData *data;

+ (void)loadSupermarketData:(CompleteBlock)complete;
@end

@interface HYSuperMarketData : NSObject

@property (nonatomic,strong)NSArray<ProductCategory *> *categories;
//@property (nonatomic,strong)NSArray<ProductChildCategory *> *childCategories;

@property (nonatomic,strong)id products;

@end

@interface HYGoods : NSObject

//*************************商品模型默认属性**********************************
/// 商品ID
@property (nonatomic,copy) NSString *gid;
/// 商品姓名
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *brand_id;
/// 超市价格
@property (nonatomic,copy) NSString *market_price;
@property (nonatomic,copy) NSString *cid;
@property (nonatomic,copy) NSString *category_id;
@property (nonatomic,copy) NSString *child_cid;

@property (nonatomic,copy) NSString *partner_price;
//@property (nonatomic, assign) CGFloat partner_price;
@property (nonatomic,copy) NSString *pre_img;
@property (nonatomic,copy) NSString *pre_imgs;
/// 当前价格
@property (nonatomic,copy) NSString *price;
//@property (nonatomic, assign) double price;
/// 库存
@property (nonatomic,assign) NSInteger number;
@property (nonatomic, assign) NSUInteger store_nums;
/// 买一赠一
@property (nonatomic,copy) NSString *pm_desc;
@property (nonatomic,assign) NSInteger had_pm;
@property (nonatomic,copy) NSString *img;
/// 是不是精选 0 : 不是, 1 : 是
@property (nonatomic,assign) NSInteger is_xf;
//*************************商品模型辅助属性**********************************
// 记录用户对商品添加次数
@property (nonatomic,assign) NSInteger userBuyNumber;
// 记录用户对商品购买的条目数量
@property (nonatomic, assign) NSUInteger itemNumOnList;


@end

@interface ProductCategory : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
//@property (nonatomic, strong) NSArray <HYGoods *> *products;
@property (nonatomic, strong) NSArray *cids;
//@property (nonatomic, strong) NSArray *child_cid;

@property (nonatomic, strong) NSArray<ProductChildCategory *> *childCategories;
@end
@interface ProductChildCategory : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pcid;
//@property (nonatomic, copy) NSString *child_cid;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, strong) NSArray <HYGoods *> *products;

@end

