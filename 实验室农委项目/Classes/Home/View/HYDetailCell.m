//
//  HYDetailCell.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/7.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYDetailCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface HYDetailCell()
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation HYDetailCell

-(instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        UIView *superview = self.contentView;
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(superview);
        }];
        
    }
    return self;
}
-(void)setModel:(ProductChildCategory *)model{
    _model = model;
//    self.textLabel.text = model.name;
//    self.nameLabel.text = model.name;
    self.iconView.image = [UIImage imageNamed: model.img];
    self.iconView.layer.cornerRadius = 10.f;
    self.iconView.layer.masksToBounds = YES;
    
}

@end
