//
//  HYShopCartCell.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/13.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYShopCartCell.h"
#import "HYGoods.h"
#import "HYBuyView.h"
#import "HYShopCartTool.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface HYShopCartCell ()
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIImageView *shoppingIcon;
@property (nonatomic, strong) UILabel *shoppingName;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *buyNumberLabel;
@property (nonatomic, strong) HYBuyView *buyView;
@end
@implementation HYShopCartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _selectedBtn = [[UIButton alloc]init];
        _selectedBtn.selected = YES;
        [_selectedBtn setImage:[UIImage imageNamed:@"v2_noselected"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"v2_selected"] forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(shoppingSelectedClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _shoppingIcon = [[UIImageView alloc]init];
        _shoppingName = [[UILabel alloc]init];
        _shoppingName.font = [UIFont systemFontOfSize:15];
        _shoppingName.textAlignment = NSTextAlignmentLeft;
        
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.font = [UIFont systemFontOfSize:15];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.textColor = [UIColor redColor];

        _buyView = [[HYBuyView alloc] init];
        [self addSubview:_selectedBtn];
        [self addSubview:_shoppingIcon];
        [self addSubview:_shoppingName];
        [self addSubview:_moneyLabel];
//        [self addSubview:_buyView];
        UILabel *numberLabel = [[UILabel alloc] init];
        self.buyNumberLabel = numberLabel;
        [self addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-2);
            make.trailing.equalTo(self).offset(-2);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(25);
        }];
//        [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self).offset(-2);
//            make.trailing.equalTo(self).offset(-2);
//            make.width.mas_equalTo(65);
//            make.height.mas_equalTo(25);
//        }];

        
        [_selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(15);
            make.leading.equalTo(self).offset(10);
            make.centerY.equalTo(self);
        }];
        [_shoppingIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(50);
            make.leading.equalTo(_selectedBtn.mas_trailing).offset(5);
            make.centerY.equalTo(self);
        }];
        [_shoppingName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_shoppingIcon.mas_trailing);
            make.trailing.equalTo(self);
            make.height.mas_equalTo(15);
            make.top.equalTo(_shoppingIcon);
        }];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_shoppingIcon.mas_trailing);
            make.width.mas_equalTo(80);
            make.bottom.equalTo(_shoppingIcon.mas_bottom);
            make.height.mas_equalTo(15);
        }];
//        [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self).offset(-2);
//            make.trailing.equalTo(self).offset(-2);
//            make.width.mas_equalTo(65);
//            make.height.mas_equalTo(25);
//        }];
    }
    return self;
}
- (void)shoppingSelectedClick:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
        [[HYShopCartTool sharedCartTool]removeFromProductShopCar:self.product];
        [[NSNotificationCenter defaultCenter] postNotificationName:HYShopCartRemoveProductNofitication object:nil];
//        self.selectCallBack(btn.selected);
    }else{
        btn.selected = YES;;
        [[HYShopCartTool sharedCartTool]addSupermarkProductToShopCar:self.product];
        [[NSNotificationCenter defaultCenter] postNotificationName:HYShopCartBuyNumberDidChangeNofitication object:nil];
//        self.selectCallBack(btn.selected);
    }
}

- (void)setProduct:(HYGoods *)product{
    _product = product;
    _buyView.product = product;
    _moneyLabel.text = self.product.price;
    
    _shoppingName.text = self.product.name;
    _buyNumberLabel.text = [NSString stringWithFormat:@"已选%ld 件",(long)self.product.userBuyNumber];
    //
    _selectedBtn.selected = YES;
    [_shoppingIcon sd_setImageWithURL:[NSURL URLWithString:self.product.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_half_size"]];
    
}


@end
