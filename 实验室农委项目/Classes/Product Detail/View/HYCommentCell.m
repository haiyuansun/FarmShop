//
//  HYCommentCell.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/10.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYCommentCell.h"
#import "HYCommentModel.h"
#import <Masonry/Masonry.h>
#import "UILabel+AdjustLabelFrame.h"

#define topHeight 60

@interface HYCommentCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation HYCommentCell
#pragma mark - 懒加载
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *lb = [[UILabel alloc] init];
        [lb setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:15.f]];
        _nameLabel = lb;
    }
    return _nameLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        UILabel *lb = [[UILabel alloc] init];
        _dateLabel = lb;
    }
    return _dateLabel;
}
-(UILabel *)commentLabel{
    if (!_commentLabel) {
        UILabel *lb = [[UILabel alloc] init];
        lb.numberOfLines = 0;
        [lb setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:15.f]];
        _commentLabel = lb;
    }
    return _commentLabel;
}
-(UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *v = [[UIImageView alloc] init];
        v.layer.masksToBounds = YES;
        v.layer.cornerRadius = 30;
        [v.layer setBorderWidth:2.f];
        [v.layer setBorderColor:[UIColor colorWithRed:10.f/255.0 green:166.f/255.0 blue: 118/225.f alpha:1.0f].CGColor];
        _iconView = v;
    }
    return _iconView;
}

#pragma mark -initMethods
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
//        [self setupUI];
    }
    return self;
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
-(void)layoutSubviews{
//    [self.commentLabel sizeToFit];
    [self setupUI];
}


-(void)setupUI{
//    self.userInteractionEnabled = NO;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(20);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(topHeight);
        make.width.mas_equalTo(60);
    }];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(20);
        make.bottom.mas_equalTo(self.iconView.mas_centerY);
        make.left.mas_equalTo(self.iconView.mas_right).offset(20);
        make.width.mas_equalTo(100);
    }];
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom);
        make.bottom.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.nameLabel);
        make.width.mas_equalTo(self.nameLabel);
    }];
    
    [self.contentView addSubview:self.commentLabel];
    
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.right.mas_equalTo(self.contentView).offset(-20);
        make.bottom.mas_equalTo(self.contentView).offset(-20);
    }];
}

#pragma mark - external methods
//-(CGFloat)

@end
