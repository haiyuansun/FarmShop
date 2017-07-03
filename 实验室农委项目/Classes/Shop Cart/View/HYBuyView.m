//
//  AJBuyView.m
//  loveFreshPeak
//
//  Created by ArJun on 16/7/29.
//  Copyright © 2016年 阿俊. All rights reserved.
//

#import "HYBuyView.h"
#import <Masonry/Masonry.h>
#import "HYShopCartTool.h"
#import <SVProgressHUD/SVProgressHUD.h>
//#import "AJUserShopCarTool.h"
//#import "AJProgressHUDManager.h"

@interface HYBuyView ()
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *cutBtn;
@property (nonatomic, strong) UILabel *countLable;
@property (nonatomic, strong) UILabel *OOSLabel;
@property (nonatomic, assign) NSInteger goodsIndex;
@end

@implementation HYBuyView

- (instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    _addBtn = [[UIButton alloc]init];
    [_addBtn setImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    
    _cutBtn = [[UIButton alloc]init];
    [_cutBtn setImage:[UIImage imageNamed:@"v2_reduce"] forState:UIControlStateNormal];
    [_cutBtn addTarget:self action:@selector(cutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cutBtn];
    
    _countLable = [[UILabel alloc]init];
    _countLable.text = @"0";
    _countLable.font = [UIFont systemFontOfSize:14];
    _countLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_countLable];
    
    _OOSLabel = [[UILabel alloc]init];
    _OOSLabel.text = @"补货中";
    _OOSLabel.hidden = YES;
    _OOSLabel.textColor = [UIColor redColor];
    _OOSLabel.font = [UIFont systemFontOfSize:15];
    _OOSLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_OOSLabel];
    
    [_cutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(self.mas_height);
    }];
    [_countLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_cutBtn.mas_trailing).offset(3);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.trailing.equalTo(_addBtn.mas_leading).offset(-2);
    }];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(self.mas_height);
    }];
    [_OOSLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];    return self;
}

- (void)setGoodsIndex:(NSInteger)goodsIndex{
    _goodsIndex = goodsIndex;
    if (self.zearNeverShow) {
        self.cutBtn.hidden = YES;
        self.countLable.hidden = YES;
    }else {
        if (goodsIndex == 0) {
            self.cutBtn.hidden = YES  && !self.zearIsShow;
            self.countLable.hidden = YES  && !self.zearIsShow;
        }else {
            self.countLable.text = [NSString stringWithFormat:@"%ld",goodsIndex];
            self.cutBtn.hidden = NO;
            self.countLable.hidden = NO;
        }
    }
}

-(void)setProduct:(HYGoods *)product{
    _product = product;
    if (product.store_nums <= 0) {
        [self supplementLabelShow:YES];
    }else {
        [self supplementLabelShow:NO];
    }
    self.goodsIndex = _product.userBuyNumber;
//    self.goodsIndex = 0;
}

- (void)supplementLabelShow:(BOOL)is{
    if (is) {
        self.OOSLabel.hidden = NO;
        self.countLable.hidden = YES;
        self.addBtn.hidden = YES;
        self.cutBtn.hidden = YES;
    }else {
        self.OOSLabel.hidden = YES;
        self.countLable.hidden = NO;
        self.addBtn.hidden = NO;
        self.cutBtn.hidden = NO;
    }
}

/**
 *  增加所点击商品数量
 */
- (void)addButtonClick:(UIButton *)btn{
    if (self.goodsIndex >= self.product.store_nums) {  // 添加商品  如果大于库存数
//        [[NSNotificationCenter defaultCenter] postNotificationName:HYGoodsInventoryProblem object:self.product.name];
//        NSString *statusStr = [NSString stringWithFormat:@"%@ 库存不足了 先买这么多，过段时间再来看看吧~",self.goods.name];
        DLog(@"库存不足");
//        [AJProgressHUDManager showImage:[UIImage imageNamed:@"v2_orderSuccess"] status:statusStr];
        [SVProgressHUD showInfoWithStatus:@"库存不足，我们正在努力"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    DLog(@"%@", self.product.name);
    self.goodsIndex++;
    self.changeBlock((int)self.goodsIndex);
    NSLog(@"self.goodsIndex = %ld",(long)self.goodsIndex);
    self.product.userBuyNumber = self.goodsIndex;
    self.countLable.text = [NSString stringWithFormat:@"%ld",self.goodsIndex];
//    [[HYShopCartTool sharedCartTool] addSupermarkProductToShopCar:self.product];
//    [[NSNotificationCenter defaultCenter] postNotificationName:HYShopCartBuyNumberDidChangeNofitication object:nil];
}
/**
 *  减减所点击商品数量
 */
- (void)cutButtonClick:(UIButton *)btn{

    if (self.goodsIndex <= 0) {
        return;
    }

    self.goodsIndex--;
    self.changeBlock((int)self.goodsIndex);
    self.product.userBuyNumber = self.goodsIndex;
    if (self.goodsIndex == 0) {
//        [[HYShopCartTool sharedCartTool] removeFromProductShopCar:self.product];
    }else {
        self.countLable.text = [NSString stringWithFormat:@"%ld",self.goodsIndex];
    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:HYShopCartBuyNumberDidChangeNofitication object:nil];
}

@end
