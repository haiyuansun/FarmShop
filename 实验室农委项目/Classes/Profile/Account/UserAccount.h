//
//  UserAccount.h
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/21.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <MJExtension/MJExtension.h>

@interface UserAccount : NSObject
/*access_token*/
@property (nonatomic, copy) NSString *access_token;
/*access_token生命周期 以秒为单位*/
@property (nonatomic, assign) NSTimeInterval expires_in;
/*access_token过期日期*/
@property (nonatomic, strong) NSDate *expires_date;
/*授权用户的uid*/
@property (nonatomic, copy) NSString *uid;
/*用户昵称*/
@property (nonatomic, copy) NSString *screen_name;
/**/
@property (nonatomic, copy) NSString *province;
/**/
@property (nonatomic, copy) NSString *city;
/**/

@property (nonatomic, copy) NSString *location;

/*个人描述*/
@property (nonatomic, copy) NSString *profile;
/*头像 大图*/
@property (nonatomic, copy) NSString *avatar_large;
/*性别*/
@property (nonatomic, copy) NSString *gender;

-(void)saveUserAccount;
+(UserAccount *)loadUserAccount;







@end
