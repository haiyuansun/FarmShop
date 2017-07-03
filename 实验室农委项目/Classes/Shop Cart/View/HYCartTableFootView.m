//
//  AJTableFootView.m
//  loveFreshPeak
//
//  Created by ArJun on 16/8/14.
//  Copyright © 2016年 阿俊. All rights reserved.
//

#import "HYCartTableFootView.h"
#import <Masonry/Masonry.h>

@interface HYCartTableFootView ()
@property (nonatomic, strong) UILabel *money;
@property (nonatomic, strong) UIButton *commitBtn;
@end
@implementation HYCartTableFootView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _money = [[UILabel alloc]init];
        _money.font = [UIFont systemFontOfSize:15];
        _money.textColor = [UIColor redColor];
        [self addSubview:_money];
        
        _commitBtn = [[UIButton alloc]init];
        [_commitBtn setTitle:@"确认购买" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = ButtonTitleFont;
        [_commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"Button_plain"] forState:UIControlStateNormal];
        [_commitBtn setBackgroundImage:[UIImage imageNamed:@"Button_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:_commitBtn];
        
        [_money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.width.equalTo(@100);
            make.leading.equalTo(self).offset(15);
            make.height.equalTo(@15);
        }];
        [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.trailing.equalTo(self);
            make.height.equalTo(self);
            make.width.equalTo(@100);
        }];
    }
    return self;
}
- (void)setSumMoney:(CGFloat)sumMoney{
    _sumMoney = sumMoney;
    self.money.text = [NSString stringWithFormat:@"共 ￥%.2lf",sumMoney];
}
- (void)commitBtnClick{
    if ([self.delegate respondsToSelector:@selector(didTableFootViewCommit)] ) {
        [self.delegate didTableFootViewCommit];
    }
}
@end
