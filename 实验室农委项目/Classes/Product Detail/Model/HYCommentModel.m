//
//  HYCommentModel.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/10.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYCommentModel.h"
#import "HYCommentCell.h"
#import "UILabel+AdjustLabelFrame.h"

@implementation HYCommentModel


-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
