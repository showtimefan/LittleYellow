//
//  AppDelegate.m
//  Yellow
//
//  Created by Coffee on 15/3/20.
//  Copyright (c) 2015年 LSZ. All rights reserved.
//

#import "AppDelegate.h"
#import "MMTabBarController.h"
#import "PhotosVController.h"
#import "YEVideosViewController.h"
@interface AppDelegate ()
@property (strong, nonatomic) UITabBarController* tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [UIApplication sharedApplication].statusBarHidden = YES;

    _tabBarController = [[MMTabBarController alloc] init];
    NSMutableArray* viewControlers = [NSMutableArray array];

    //视频
    UIViewController* viewController = [[YEVideosViewController alloc] init];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navController.navigationBarHidden = YES;
    [viewControlers addObject:navController];

    //照片
    viewController = [[PhotosVController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [viewControlers addObject:navController];

    //设置
    viewController = [[PhotosVController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [viewControlers addObject:navController];

    [_tabBarController setViewControllers:viewControlers];
    self.window.rootViewController = _tabBarController;

    self.window.backgroundColor = [UIColor colorWithRed:0.216f green:0.275f blue:0.361f alpha:1.00f];
    [self.window makeKeyAndVisible];
    return YES;

    return YES;
}


@end
