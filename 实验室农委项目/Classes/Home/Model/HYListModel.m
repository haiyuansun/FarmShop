//
//  HYListModel.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/8.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYListModel.h"

@implementation HYListModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if ((self = [super init])) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
