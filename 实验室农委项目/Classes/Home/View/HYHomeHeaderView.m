//
//  HYHomeHeaderView.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/7.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYHomeHeaderView.h"
@interface HYHomeHeaderView()
@property (nonatomic, strong) UILabel *textLabel;
@end


@implementation HYHomeHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, screenWidth, 20)];
        self.textLabel = lb;
        [self addSubview:lb];
//        self.frame = CGRectMake(0, 0, WIDTH, 25);
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = tColor;
    }
    return self;
}
-(void)setModel:(ProductCategory *)model{
    _model = model;
    self.textLabel.text = model.name;
}

@end
