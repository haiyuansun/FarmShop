//
//  HYShopList.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/27.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYShopList.h"
#import "HYGoods.h"
#import "NSString+Extension.h"
#import "HYShopCartTool.h"

@interface HYShopList()

@end

@implementation HYShopList

-(instancetype)initWithSingleItem:(HYGoods *)product{
    if (self = [super init]) {
        self.userBuyProducts = [NSArray arrayWithObject:product];
        CGFloat cost = product.userBuyNumber * [[product.price cleanDecimalPointZear] doubleValue];
        self.totalCost = cost;
        [self setListInfo];
    }
    return self;
}

-(instancetype)initWithItems:(NSArray *)products andTotalCost:(CGFloat)cost{
    if (self = [super init]) {
        self.userBuyProducts = [products copy];
        self.totalCost = cost;
        [self setListInfo];
    }
    return self;
}

#pragma setListInfo
-(void)setListInfo{
    self.listId  = @"this is a test string for these orders.";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY年MM月dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *nowtimeStr = [formatter stringFromDate:datenow];
    
//    NSLog(@"nowtimeStr =  %@",nowtimeStr);
    self.createTime = nowtimeStr;
    
}

@end
