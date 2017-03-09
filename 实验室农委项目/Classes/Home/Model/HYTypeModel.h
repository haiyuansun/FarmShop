//
//  HYTypeModel.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/7.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYDetailModel.h"

@interface HYTypeModel : NSObject
@property (nonatomic, copy)  NSString *title;
@property (nonatomic, strong) NSArray *detailList;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)typeModelWithDict: (NSDictionary *)dict;

@end
