//
//  HYLikeCell.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/23.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYLikeCell.h"
#import "StarsView.h"
#import "HYGoods.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface HYLikeCell ()
@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *reviewLabel;
@property (nonatomic, strong) StarsView *starView;

@end

@implementation HYLikeCell
#pragma mark - 懒加载
-(UIImageView *)iv{
    if (!_iv) {
        _iv = [[UIImageView alloc] init];
    }
    return _iv;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:13.f];
        
    }
    return _nameLabel;
}
- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:13.f];
        
    }
    return _priceLabel;
}
- (UILabel *)reviewLabel{
    if (!_reviewLabel) {
        _reviewLabel = [[UILabel alloc] init];
        _reviewLabel.font = [UIFont systemFontOfSize:13.f];
        
    }
    return _reviewLabel;
}
- (StarsView *)starView{
    if (!_starView) {
        _starView = [[StarsView alloc] initWithStarSize:CGSizeMake(10, 10) space:1 numberOfStar:5];
        
    }
    return _starView;
}
#pragma mark setter
-(void)setProduct:(HYGoods *)product{
    _product = product;
    [self.iv sd_setImageWithURL:[NSURL URLWithString:product.img]];
    self.nameLabel.text = product.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@", product.price];
    self.reviewLabel.text = @"90 条评论";
    self.starView.score = 4.5;
    
}



#pragma mark - methods
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.contentView addSubview:self.iv];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.reviewLabel];
    [self.contentView addSubview:self.starView];
//    self.contentView.backgroundColor = [UIColor redColor];
    
    [_iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iv.mas_bottom).offset(5);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
        make.centerX.mas_equalTo(self.contentView);
    }];
//    _nameLabel.center.x = self.contentView.center.x;
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(10);
    }];

    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.starView.mas_bottom).offset(5);
        make.height.mas_equalTo(10);
        make.left.mas_equalTo(self.contentView).offset(5);
    }];
    [_reviewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(self.priceLabel);
        make.height.mas_equalTo(10);
    }];
}






@end
