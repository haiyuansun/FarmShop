//
//  HYSettingCell.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/23.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYSettingCell.h"
#import "UIView+AdjustFrame.h"
@interface HYSettingCell()

@property (nonatomic, strong) UILabel *textLb;
@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) UILabel *detailLb;

@end


@implementation HYSettingCell
#pragma mark - 懒加载

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    self.detailTextLabel.text = @"123";
//    self.detailTextLabel.hidden = NO;
//    self.imageView.frame = CGRectMake(0, 0, 20, 20);
//    CGFloat width = self.textLabel.width;
//    CGFloat height = self.textLabel.height;
    self.textLabel.x = 50;
//    self.detailTextLabel.x = 120;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1].CGColor);
//    CGContextStrokeRect(context, CGRectMake(20, 0, rect.size.width - 40, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(20, rect.size.height, rect.size.width - 40, 1));
}

@end
