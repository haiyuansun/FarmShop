//
//  AccountViewModel.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/21.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserAccount;

typedef void(^FinishBlock)(NSError *error);

@interface AccountViewModel : NSObject

@property (nonatomic, assign, getter=isUserLogin) BOOL userLogin;

-(void)loadTokenInfoWithCode: (NSString *)code andFinishBlock:(FinishBlock) block;
//+(instancetype)sharedInstance;
@property (nonatomic, strong) UserAccount *userAccount;

@end
