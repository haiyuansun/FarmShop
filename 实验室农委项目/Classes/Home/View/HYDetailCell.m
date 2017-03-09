//
//  HYDetailCell.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/7.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYDetailCell.h"
#import <Masonry/Masonry.h>

@interface HYDetailCell()
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation HYDetailCell

-(instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        UILabel *lb = [[UILabel alloc] init];
        UIView *superview = self.contentView;
        self.textLabel = lb;
        [self.contentView addSubview: lb];
        self.backgroundColor = RandomColor;
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(superview.mas_left);
            make.right.mas_equalTo(superview.mas_right);
            make.centerX.mas_equalTo(superview.mas_centerX);
            make.height.mas_equalTo(@20);
        }];
        lb.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
-(void)setModel:(HYDetailModel *)model{
    _model = model;
    self.textLabel.text = model.name;
}

@end
