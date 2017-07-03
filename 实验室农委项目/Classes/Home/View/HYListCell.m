//
//  HYListCell.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/8.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYListCell.h"
#import "HYListModel.h"
#import "HYGoods.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface HYListCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
//@property (nonatomic, copy) NSMutableAttributedString *attrStr;


@end

@implementation HYListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setGoodModel:(HYGoods *)goodModel{
    _goodModel = goodModel;
    self.nameLabel.text = goodModel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@", goodModel.price];
    self.storeLabel.text = [NSString stringWithFormat:@"剩余: %ld", goodModel.store_nums];
    [self.iv sd_setImageWithURL:[NSURL URLWithString:self.goodModel.img] placeholderImage:[UIImage imageNamed:PlaceHolderImageName]];
    NSString *tempString = [NSString stringWithFormat:@"¥ %@", _goodModel.market_price];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:tempString];
    NSDictionary *attrDict = @{NSStrikethroughStyleAttributeName:@1};
    [str setAttributes:attrDict range:NSMakeRange(0, str.length)];
    self.originalPriceLabel.attributedText = str;
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    self.iv.frame = CGRectMake(8, 9, 46, 46);
}
#pragma mark -methods
//画分割线
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(20, 0, rect.size.width - 40, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(20, rect.size.height, rect.size.width - 40, 1));
}


@end
