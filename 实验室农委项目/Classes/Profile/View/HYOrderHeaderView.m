//
//  HYOrderHeaderView.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/28.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYOrderHeaderView.h"
#import <Masonry/Masonry.h>

@interface HYOrderHeaderView ()
@property (nonatomic, strong) UILabel *listLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation HYOrderHeaderView
-(instancetype)init{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
#pragma mark setupUI
-(void)setupUI{
    _listLabel = [[UILabel alloc] init];
    _listLabel.font = [UIFont systemFontOfSize:13.f];
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:13.f];
    int randomNumber = (arc4random() % 6) + 1;
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"dot%d", randomNumber]]];
    [self addSubview:iv];
    [self addSubview:_listLabel];
    [self addSubview:_timeLabel];
    [iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(5);
        make.centerY.mas_equalTo(self);
        make.width.and.height.mas_equalTo(10);
    }];
    [_listLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(iv.mas_trailing).offset(10);
        make.height.mas_equalTo(20);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.listLabel.mas_bottom);
        make.left.mas_equalTo(self.listLabel);
        make.height.mas_equalTo(20);
    }];
}
-(void)setCreateStr:(NSString *)createStr{
    _createStr = createStr;
    self.timeLabel.text = [NSString stringWithFormat:@"订单生成日期: %@", createStr];
}
-(void)setListId:(NSString *)listId{
    _listId = listId;
    self.listLabel.text = [NSString stringWithFormat:@"订单编号: %@",listId];
}

@end
