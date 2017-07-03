//
//  HYCommentTableViewCell.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/11.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYCommentTableViewCell.h"


@interface HYCommentTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;


@end

@implementation HYCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.commentLabel.numberOfLines = 0;
    [self.commentLabel setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:15.f]];
    [self.nameLabel setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:15.f]];
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = 30;
    [self.iconView.layer setBorderWidth:2.f];
    [self.iconView.layer setBorderColor:[UIColor colorWithRed:10.f/255.0 green:166.f/255.0 blue: 118/225.f alpha:1.0f].CGColor];
//    [self.iconView invalidateIntrinsicContentSize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark -methods
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
-(void)setModel:(HYCommentModel *)model{
    _model = model;
    self.nameLabel.text = model.userString;
    self.commentLabel.text = model.content;
    self.commentLabel.preferredMaxLayoutWidth = screenWidth - 20;
    self.dateLabel.text = model.dateString;
    self.iconView.image = [UIImage imageNamed: model.userIcon];
    [self layoutIfNeeded];
    //    [self setupUI];
    
}


@end
