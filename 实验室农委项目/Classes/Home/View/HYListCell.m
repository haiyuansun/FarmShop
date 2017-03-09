//
//  HYListCell.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/8.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYListCell.h"
#import "HYListModel.h"
@interface HYListCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
@property (nonatomic, copy) NSMutableAttributedString *attrStr;


@end

@implementation HYListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"¥100"];
    NSDictionary *attrDict = @{NSStrikethroughStyleAttributeName:@1};
    [str setAttributes:attrDict range:NSMakeRange(0, str.length)];
    self.attrStr = str;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setListModel:(HYListModel *)listModel{
    _listModel = listModel;
    self.nameLabel.text = listModel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@", listModel.price];
    self.storeLabel.text = listModel.base;
    self.iv.image = [UIImage imageNamed:listModel.image];
    self.originalPriceLabel.attributedText = self.attrStr;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.iv.frame = CGRectMake(8, 9, 46, 46);
}

@end
