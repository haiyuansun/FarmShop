//
//  HYSelectTypeView.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/19.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYSelectTypeView.h"
#import <Masonry/Masonry.h>
#import "UIButton+FitSize.h"
#define margin 10
#define buttonHeight 50
#define titleLabelHeight 15


@interface HYSelectTypeView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSArray *selectBtns;
@property (nonatomic, strong) UIButton *selectedBtn;
@end

@implementation HYSelectTypeView

-(instancetype)initWithTitle:(NSString *)title Selections:(NSArray *)selections{
    if (self = [super init]) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = title;
        [self addSubview: _titleLabel];
        NSMutableArray *M_Array = [NSMutableArray array];
        for (int i = 0; i < selections.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            [btn setTitle:selections[i] forState:UIControlStateNormal];
//            [self addSubview: btn];
            [btn addTarget:self action:@selector(typeBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
            [M_Array addObject:btn];
            
        }
        _selectBtns = [M_Array copy];
        _selectedBtn = [_selectBtns objectAtIndex:0];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(margin);
        make.top.mas_equalTo(self).offset(margin);
        make.height.mas_equalTo(15);
    }];
    
    //calculation
    int i = 0, j = 0, k = 0, totalWidth = 0;
    while (k < self.selectBtns.count) {
        UIButton *button = self.selectBtns[k];
        [self addSubview:button];
        button.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:98.0/255 green:200.0/255 blue:122.0/255 alpha:1.0]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button sizeToFit];
        CGFloat btnWidth = button.width;
        [button.layer setCornerRadius:6];
        button.layer.masksToBounds = YES;
//        DLog(@"%f", btnWidth);
        totalWidth += (btnWidth + margin);
        if (totalWidth > self.width) {
            i++;
            j = 0;
            totalWidth = btnWidth + margin;
        }
        int offsetY = (i+1) * margin + i * buttonHeight + titleLabelHeight + 10;
        if (j == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self).offset(margin);
                make.top.mas_equalTo(self).offset(offsetY);
            }];

        }else{
            int offsetX = totalWidth - btnWidth;
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.mas_equalTo(self).offset(offsetX);
                make.top.mas_equalTo(self).offset(offsetY);
            }];
        }
        j++;
        k++;
    }
    //分割线
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(20, self.height - 1, self.width, 1)];
    [separatorLine setBackgroundColor:[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1]];
    [self addSubview:separatorLine];
    
}
#pragma mark -methods
-(void)typeBtnDidClick:(UIButton *)button{
    DLog(@"%ld", (long)button.tag);
    _selectedBtn.selected = NO;
    button.selected = YES;
    _selectedBtn = button;
}

@end
