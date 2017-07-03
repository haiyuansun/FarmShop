//
//  HYHomeHeaderView.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/7.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYTypeModel.h"
#import "HYGoods.h"

@interface HYHomeHeaderView : UICollectionReusableView
//@property (nonatomic, copy) NSString *textString;
@property (nonatomic, strong) ProductCategory *model;
@end
