//
//  AccountViewModel.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/21.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "AccountViewModel.h"
#import "UserAccount.h"
#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>


@interface AccountViewModel ()


@end

@implementation AccountViewModel

//singleton
//static AccountViewModel *_instance;
//+(instancetype)allocWithZone:(struct _NSZone *)zone{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [super allocWithZone:zone];
//        
//    });
//    return _instance;
//}
//+(instancetype)sharedInstance{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [[self alloc] init];
//    });
//    return _instance;
//}
//-(id)copyWithZone:(struct _NSZone *)zone{
//    return _instance;
//}


-(instancetype)init{
    if (self = [super init]) {
        self.userAccount = [UserAccount loadUserAccount];
    }
    return self;
}

-(void)loadTokenInfoWithCode:(NSString *)code andFinishBlock:(FinishBlock)block{
    NSString *urlString = @"https://api.weibo.com/oauth2/access_token";
    NSDictionary *dict = @{@"client_id": HYWeiboAppKey, @"client_secret": HYWeiboAppSecret, @"grant_type": @"authorization_code", @"code": code, @"redirect_uri": HYWeiboRedirectUrl};
//    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:dict error:nil];
    AFHTTPSessionManager *AFN = [AFHTTPSessionManager manager];
//    [AFN.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [AFN POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = responseObject;
        UserAccount *userAccount = [UserAccount mj_objectWithKeyValues:result];
        [self loadUserInfoWithAccount:userAccount finishBlock:block];
//        DLog(@"%@",result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(error);
    }];
}
-(void)loadUserInfoWithAccount:(UserAccount *)userAccount finishBlock:(FinishBlock)block{
    NSString *urlString = @"https://api.weibo.com/2/users/show.json";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *paramters = @{@"access_token": userAccount.access_token, @"uid": userAccount.uid};
    [manager GET:urlString parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *result = responseObject;
        userAccount.screen_name = result[@"name"];
        userAccount.avatar_large = result[@"avatar_large"];
        userAccount.profile = result[@"description"];
        userAccount.location = result[@"location"];
        userAccount.gender = result[@"gender"];
        [[NSNotificationCenter defaultCenter] postNotificationName:HYRootViewControllerChangeName object: @{@"isVisitor":@"NO"}];
        [userAccount saveUserAccount];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(error);
    }];
    
}
//getter
-(BOOL)isUserLogin{
    return self.userAccount.access_token != nil;
}

@end
