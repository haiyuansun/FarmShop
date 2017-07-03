//
//  HYOrderCell.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/28.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYOrderCell.h"
#import "HYGoods.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface HYOrderCell ()
@property (nonatomic, strong) UIImageView *shoppingIcon;
@property (nonatomic, strong) UILabel *shoppingName;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *buyNumberLabel;
//@property (nonatomic, strong) HYBuyView *buyView;

@end

@implementation HYOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _shoppingIcon = [[UIImageView alloc]init];
        _shoppingName = [[UILabel alloc]init];
        _shoppingName.font = [UIFont systemFontOfSize:15];
        _shoppingName.textAlignment = NSTextAlignmentLeft;
        
        _moneyLabel = [[UILabel alloc]init];
        _moneyLabel.font = [UIFont systemFontOfSize:15];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.textColor = [UIColor redColor];
        
//        _buyView = [[HYBuyView alloc] init];
        [self addSubview:_shoppingIcon];
        [self addSubview:_shoppingName];
        [self addSubview:_moneyLabel];
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.font = [UIFont systemFontOfSize:14.f];
        self.buyNumberLabel = numberLabel;
        [self addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self).offset(-2);
            make.centerY.mas_equalTo(self.shoppingName);
            make.trailing.equalTo(self).offset(-2);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(25);
        }];
        
        [_shoppingIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(50);
            make.leading.equalTo(self).offset(5);
            make.centerY.equalTo(self);
        }];
        [_shoppingName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_shoppingIcon.mas_trailing).offset(10);
            make.trailing.equalTo(self);
            make.height.mas_equalTo(15);
            make.top.equalTo(_shoppingIcon);
        }];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_shoppingIcon.mas_trailing).offset(10);
            make.width.mas_equalTo(80);
            make.bottom.equalTo(_shoppingIcon.mas_bottom);
            make.height.mas_equalTo(15);
        }];
    }
    return self;
}

- (void)setProduct:(HYGoods *)product{
    _product = product;
    _moneyLabel.text = [NSString stringWithFormat:@"单价:¥%@",self.product.price];
    
    _shoppingName.text = self.product.name;
    _buyNumberLabel.text = [NSString stringWithFormat:@"购买%ld件",(long)self.product.itemNumOnList];
    //
//    _selectedBtn.selected = YES;
    [_shoppingIcon sd_setImageWithURL:[NSURL URLWithString:self.product.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_half_size"]];
    
}

@end
