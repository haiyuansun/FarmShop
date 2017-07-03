//
//  AJBuyView.h
//  loveFreshPeak
//
//  Created by ArJun on 16/7/29.
//  Copyright © 2016年 阿俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYGoods.h"


typedef void(^buyViewChangedBlock)(int number);

@interface HYBuyView : UIView
/*
 * 是否显示0
 */
@property (nonatomic, assign) BOOL zearIsShow;
/*
 * 关联的商品模型
 */
@property (nonatomic, strong) HYGoods *product;
/*
 * 不显示减号
 */
@property (nonatomic, assign) BOOL zearNeverShow;

@property (nonatomic, copy) buyViewChangedBlock changeBlock;


@end
