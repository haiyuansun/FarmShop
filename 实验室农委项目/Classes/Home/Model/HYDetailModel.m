//
//  HYDetailModel.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/7.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYDetailModel.h"

@implementation HYDetailModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    if ((self = [super init])) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)detailModelWithDict:(NSDictionary *)dict{
    return  [[self alloc] initWithDict:dict];
}

@end
