//
//  HYProfileView.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/23.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "HYProfileView.h"
#import "UserAccount.h"
#import "HYSettingCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

#define profileIdentifier @"profileIdentifier"

@interface HYProfileView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UserAccount *userAccount;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary *> *settings;
@end

@implementation HYProfileView

-(NSArray *)settings{
    if (!_settings) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"settings.plist" ofType:nil];
        _settings = [NSArray arrayWithContentsOfFile:path];
    }
    return _settings;
}

-(instancetype)initWithUserAccount:(UserAccount *)userAccount{
    if(self = [super init]){
        _userAccount = userAccount;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    //tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
//    [_tableView registerClass:[HYSettingCell class] forCellReuseIdentifier:profileIdentifier];
}

#pragma mark -delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HYProfileViewTopView *view = [[HYProfileViewTopView alloc] initWithUserAccount:self.userAccount frame:CGRectMake(0, 0, screenWidth, 200)];
//    view.frame = CGRectMake(0, 0, screenWidth, 250);
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 250)];
//    view.backgroundColor = [UIColor redColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.block(indexPath.row);
}


#pragma mark -dataSource

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.settings.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HYSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:profileIdentifier];
//    cell.backgroundColor = RandomColor;
    if (cell == nil) {
        cell = [[HYSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:profileIdentifier];
    }
    NSDictionary *dict = [self.settings objectAtIndex:indexPath.row];
    cell.textLabel.text = dict[@"name"];
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
//    DLog(@"%@", dict[@"detail"]);
    cell.detailTextLabel.text = dict[@"detail"];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end


@interface HYProfileViewTopView ()
@property (nonatomic, strong) UserAccount *userAccount;

@end

@implementation HYProfileViewTopView
-(instancetype)initWithUserAccount:(UserAccount *)userAccount frame: (CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _userAccount = userAccount;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
        //iconView
        UserAccount *userAccount = _userAccount;
        UIImageView *userIconView = [[UIImageView alloc] init];
        userIconView.layer.cornerRadius = 40;
        userIconView.layer.masksToBounds = YES;
        userIconView.layer.borderWidth = 6.0;
        userIconView.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:userIconView];
        [userIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(30);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
        }];
        NSURL *url = [NSURL URLWithString:userAccount.avatar_large];
        [userIconView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"tx"]];
        //nameLabel
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = userAccount.screen_name;
        nameLabel.font = [UIFont fontWithName:@"ArialMT" size:15.f];
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(userIconView.mas_bottom).offset(10);
            make.height.mas_equalTo(30);
        }];
        //introLabel
        NSMutableString *str = [NSMutableString stringWithString:@"个性简介:"];
        NSString *intro = [str stringByAppendingString:userAccount.profile];
        UILabel *introLabel = [[UILabel alloc] init];
        introLabel.text = intro;
        introLabel.font = [UIFont fontWithName:@"ArialMT" size:14.f];
        [self addSubview:introLabel];
        [introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(nameLabel.mas_bottom).offset(5);
            make.height.mas_equalTo(30);
        }];
}


@end

