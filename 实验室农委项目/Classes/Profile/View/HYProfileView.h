//
//  HYProfileView.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/23.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^settingViewClickBlock)(NSUInteger index);
@class UserAccount;


@interface HYProfileView : UIView
-(instancetype)initWithUserAccount:(UserAccount *)userAccount;
@property (nonatomic, copy) settingViewClickBlock block;

@end
@interface HYProfileViewTopView : UIView
-(instancetype)initWithUserAccount:(UserAccount *)userAccount frame:(CGRect)frame;
@end

