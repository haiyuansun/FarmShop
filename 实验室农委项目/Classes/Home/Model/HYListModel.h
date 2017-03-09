//
//  HYListModel.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/8.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYListModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *base;
@property (nonatomic, copy) NSString *image;


-(instancetype)initWithDict: (NSDictionary *)dict;


@end
