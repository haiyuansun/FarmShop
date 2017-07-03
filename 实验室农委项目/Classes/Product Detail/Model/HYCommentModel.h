//
//  HYCommentModel.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/10.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCommentModel : NSObject
@property (nonatomic, copy) NSString *userString;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, copy) NSString *userIcon;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
