//
//  HYGoodsViewModel.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/15.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYGoods.h"

@interface HYGoodsViewModel : NSObject

+(instancetype)sharedGoodsViewModel;
-(HYSuperMarketData *)loadGoods;

@end
