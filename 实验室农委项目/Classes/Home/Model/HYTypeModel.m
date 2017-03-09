//
//  HYTypeModel.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/7.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYTypeModel.h"

@implementation HYTypeModel
-(instancetype)initWithDict:(NSDictionary *)dict{
    if ((self = [super init])) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)typeModelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"title"]) {
        _title = value;
    }
    else if ([key isEqualToString:@"detailList"]){
        NSArray *array = value;
        NSMutableArray *tempM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            HYDetailModel *detail = [HYDetailModel detailModelWithDict:dict];
            [tempM addObject:detail];
        }
        _detailList = [tempM copy];
    }
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
