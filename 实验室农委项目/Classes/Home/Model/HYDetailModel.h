//
//  HYDetailModel.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/7.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDetailModel : NSObject
@property (nonatomic, copy) NSString *name;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)detailModelWithDict: (NSDictionary *)dict;

@end
