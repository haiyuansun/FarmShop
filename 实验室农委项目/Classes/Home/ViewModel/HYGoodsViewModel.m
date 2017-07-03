//
//  HYGoodsViewModel.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/15.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYGoodsViewModel.h"

@interface HYGoodsViewModel()
@property (nonatomic, strong) HYSuperMarketData *data;

@end


@implementation HYGoodsViewModel
static HYGoodsViewModel *_instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+(instancetype)sharedGoodsViewModel{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
-(id)copyWithZone:(struct _NSZone *)zone{
    return _instance;
}

-(HYSuperMarketData *)loadGoods{
    if (!self.data) {
        [HYSupermarketSource loadSupermarketData:^(id data, NSError *error) {
            self.data = data;
        }];
    }

    return self.data;
}


@end
