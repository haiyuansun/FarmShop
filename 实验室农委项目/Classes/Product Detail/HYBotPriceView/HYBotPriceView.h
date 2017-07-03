//
//  HYBotPriceView.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/9.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>
//这里需要使用模型
typedef void (^BtnClickCallBack)(UIButton *buyBtn);
@interface HYBotPriceView : UIView
@property (nonatomic, copy) BtnClickCallBack buyBtnCallBackBlock;
@property (nonatomic, copy) BtnClickCallBack likeBtnCallBackBlock;
@property (nonatomic, assign) CGFloat price;

-(instancetype)initWithPrice: (CGFloat)price;

@end
