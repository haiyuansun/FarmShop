//
//  HYSelectTypeView.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/19.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYSelectTypeView : UIView
@property (nonatomic, strong) NSArray *selectionArray;

-(instancetype)initWithTitle: (NSString *)title Selections:(NSArray *)selections;
@end
