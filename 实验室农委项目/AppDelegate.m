//
//  AppDelegate.m
//  实验室农委项目
//
//  Created by 孙海源 on 2017/3/3.
//  Copyright © 2017年 孙海源. All rights reserved.
//

#import "AppDelegate.h"
#import "HYMainTabBarController.h"
#import "HYVisitorViewController.h"
#import "HYBaseNavController.h"
#import "AccountViewModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRootViewController:) name:HYRootViewControllerChangeName object:nil];
    [self setAppStyle];
    [self buildKeyWindow];
    return YES;
}

- (void)buildKeyWindow{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
//    NSString *isFirestOpenApp = [[NSUserDefaults standardUserDefaults]objectForKey:IsFirstOpenApp];
//    if (isFirestOpenApp == nil) {
//#warning mark - 这里正常是跳入到版本新特新界面
//        [self showMainTabBarController];
//        [[NSUserDefaults standardUserDefaults]setObject:IsFirstOpenApp forKey:IsFirstOpenApp];
//    }else
//    {
//        [self showMainTabBarController];
//    }
//    [self showMainTabBarController];
    AccountViewModel *account = [[AccountViewModel alloc] init];
    if (account.isUserLogin) {
        [self showMainTabBarController];
    }else{
        [self showVisitorController];
    }
}

- (void)setAppStyle{
    UITabBar *item = [UITabBar appearance];
    item.tintColor = tColor;
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    // 禁止透明度
    navigationBar.translucent = NO;
}
-(void)showVisitorController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    HYVisitorViewController *vc = [sb instantiateInitialViewController];
    HYBaseNavController *nav = [[HYBaseNavController alloc] initWithRootViewController:vc];
    nav.navigationBar.tintColor = tColor;
    self.window.rootViewController = nav;
}

- (void)showMainTabBarController
{
    self.window.rootViewController = [[HYMainTabBarController alloc]init];
    
}

-(void)changeRootViewController:(NSNotification *)notification{
    NSDictionary *dict = notification.object;
    NSString *value = dict[@"isVisitor"];
    if ([value isEqualToString:@"YES"]) {
        [self showVisitorController];
    }else{
        [self showMainTabBarController];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
