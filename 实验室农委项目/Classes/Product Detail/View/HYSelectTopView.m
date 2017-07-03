//
//  HYSelectTopView.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/19.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYSelectTopView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface HYSelectTopView ()
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *productNumLabel;

@end

@implementation HYSelectTopView

-(instancetype)initWithProdcutImageUrlString:(NSString *)Img price:(CGFloat)price productNumber:(NSUInteger)number{
    if (self = [super init]) {
        _productImageView = [[UIImageView alloc] init];
        [_productImageView sd_setImageWithURL:[NSURL URLWithString:Img] placeholderImage:[UIImage imageNamed:PlaceHolderImageName]];
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f", price];
        _productNumLabel = [[UILabel alloc] init];
        _productNumLabel.text = [NSString stringWithFormat:@"库存 %lu件", (unsigned long)number];
        [self addSubview:_productNumLabel];
        [self addSubview:_priceLabel];
        [self addSubview:_productImageView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    __weak __typeof(self) weakSelf = self;
    [_productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf).offset(20);
        make.top.mas_equalTo(weakSelf).offset(-40);
        make.height.and.width.mas_equalTo(100);
    }];
    _productImageView.layer.borderWidth = 2.0;
    _productImageView.layer.borderColor = [UIColor ht_silverColor].CGColor;
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.productImageView.mas_right).offset(10);
        make.top.mas_equalTo(weakSelf).offset(10);
        make.height.mas_equalTo(15);
    }];
    _priceLabel.textColor = [UIColor ht_carrotColor];
    [_productNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(weakSelf.priceLabel);
        make.height.mas_equalTo(weakSelf.priceLabel);
        make.top.mas_equalTo(weakSelf.priceLabel.mas_bottom).offset(5);
    }];
    //分割线
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(20, self.height - 1, self.width, 1)];
    [separatorLine setBackgroundColor:[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1]];
    [self addSubview:separatorLine];
}
#pragma mark -methods

////画分割线
//- (void)drawRect:(CGRect)rect {
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
//    
////    //上分割线，
////    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1].CGColor);
////    CGContextStrokeRect(context, CGRectMake(20, 0, rect.size.width - 40, 1));
//    
//    //下分割线
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1].CGColor);
//    CGContextStrokeRect(context, CGRectMake(20, rect.size.height, rect.size.width - 40, 1));
//}

@end
