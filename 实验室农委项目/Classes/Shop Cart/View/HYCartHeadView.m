//
//  HYCartHeadView.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/13.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYCartHeadView.h"
#import <Masonry/Masonry.h>

@implementation HYCartHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *lines = [[UIView alloc]init];
        lines.backgroundColor = tColor;
        
        UILabel *lightningLabel = [[UILabel alloc]init];
        lightningLabel.text = @"我的农场";
        lightningLabel.font = [UIFont systemFontOfSize:15];
        [lightningLabel sizeToFit];
        
        [self addSubview:lines];
        [self addSubview:lightningLabel];
        
        [lines mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(3);
            make.height.mas_equalTo(15);
            make.leading.equalTo(self).offset(10);
            make.centerY.equalTo(self);
        }];
        [lightningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(lines).offset(5);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

@end
