//
//  UserAccount.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/21.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "UserAccount.h"
#import <MJExtension/MJExtension.h>


@interface UserAccount ()<NSCoding>

@end

@implementation UserAccount
#pragma NSCoding

MJCodingImplementation




#pragma setter
-(void)setGender:(NSString *)gender{
    if ([gender isEqualToString:@"m"]) {
        _gender = @"男";
    }else if([gender isEqualToString:@"f"]){
        _gender = @"女";
    }else{
        _gender = @"未填写";
    }
}
-(void)setExpires_in:(NSTimeInterval)expires_in{
    _expires_in = expires_in;
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:expires_in];
}





#pragma methods
-(void)saveUserAccount{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [documentPath stringByAppendingPathComponent: HYUserAccountArchiveName];
    DLog(@"%@", path);
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}
+(UserAccount *)loadUserAccount{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [documentPath stringByAppendingPathComponent:HYUserAccountArchiveName];
    DLog(@"%@", path);
    UserAccount *userAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (userAccount && [userAccount.expires_date compare:[NSDate date]] == NSOrderedDescending ) {
        return userAccount;
    }
    return nil;
}

@end
