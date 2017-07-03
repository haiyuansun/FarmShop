//
//  HYBotPriceView.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/9.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYBotPriceView.h"
#import <Masonry/Masonry.h>
#import "StarsView.h"

@interface HYBotPriceView ()
@property (nonatomic, strong) UIImageView *topSeperateView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *starBtn;
@property (nonatomic, strong) StarsView *starView;


@end

@implementation HYBotPriceView


-(instancetype)initWithPrice:(CGFloat)price{
    if (self = [super init]) {
        _price = price;
        [self setupUI];

    }
    return self;
}
//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        [self setupUI];
//    }
//    return self;
//}
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super initWithCoder:aDecoder]) {
//        [self setupUI];
//    }
//    return self;
//}

-(void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    [self setupLabel];
    [self setupRightButton];
    [self setupStarButton];
//    [self setupTopView];
    [self setupStarView];
    
}
-(void)setupStarView{
    StarsView *view = [[StarsView alloc] initWithStarSize:CGSizeMake(10, 10) space:3 numberOfStar:5];
    //    view.supportDecimal = YES;
    view.score = 3.7;
//    view.frame = CGRectMake(100, 100, view.frame.size.width, view.frame.size.height);
    self.starView = view;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftLabel.mas_bottom);
        make.left.mas_equalTo(self.leftLabel).offset(2);
    }];

}

-(void)setupTopView{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.topSeperateView = view;
    [self addSubview:view];
    view.image = [UIImage imageNamed:@"分割线"];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(2);
    }];
    
}

-(void)setupLabel{
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectZero];
    self.leftLabel = lb;
//    lb.text = @"¥6.40";
//    lb.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.f];
    NSString *str1 = [NSString stringWithFormat:@"¥ %.2f", self.price];
    NSString *str2 = @"  每份";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:str1];
    [str appendAttributedString: [[NSAttributedString alloc] initWithString:str2]];
    NSDictionary *attrDict = @{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:15.f]};
    [str setAttributes:attrDict range:NSMakeRange(0, str1.length)];
    attrDict = @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont fontWithName:@"MarkerFelt-Thin" size:15.f]};
    [str addAttributes:attrDict range:NSMakeRange(str1.length, str2.length)];
    lb.attributedText = str;
//    lb.backgroundColor = [UIColor redColor];
    [self addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
        make.left.mas_equalTo(self).offset(15);
    }];
}
-(void)setupRightButton{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    
    self.rightBtn = btn;
    
    [btn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [btn setBackgroundImage:[UIImage imageNamed:@"Button_plain"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"Button_highlighted"] forState:UIControlStateHighlighted];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
        make.right.mas_equalTo(self).offset(-20);

    }];
    [btn setTitle:@"立即下单" forState:UIControlStateNormal];
//    btn.titleLabel.textColor = [UIColor blackColor];
    btn.titleLabel.font = ButtonTitleFont;
    
}
-(void)setupStarButton{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    
    self.starBtn = btn;

    [self addSubview:btn];
    [btn setBackgroundImage:[UIImage imageNamed:@"Button_plain"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"Button_highlighted"] forState:UIControlStateHighlighted];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
        make.right.mas_equalTo(self.rightBtn.mas_left).offset(-10);
        
    }];
    [btn setTitle:@"收藏货物" forState:UIControlStateNormal];
    //    btn.titleLabel.textColor = [UIColor blackColor];
    btn.titleLabel.font = ButtonTitleFont;
    
}
-(void)buyBtnClick: (UIButton *)button{
    DLog(@"...");
    self.buyBtnCallBackBlock(button);
}

@end
