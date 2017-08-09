//
//  AppDelegate.m
//  XYSideMenuDemo
//
//  Created by FireHsia on 2017/8/8.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

#import "AppDelegate.h"
#import "XYSideViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "SideViewController.h"
#import "UIViewController+XYSideCategory.h"

@interface AppDelegate ()

@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 侧拉VC
    SideViewController *leftViewController = [[SideViewController alloc] init];
    
    // 主VC
    UITabBarController *tabBarViewController = [[UITabBarController alloc] init];
    UINavigationController *navOne = [[UINavigationController alloc] initWithRootViewController:[[SecondViewController alloc] init]];
    UINavigationController *navTwo = [[UINavigationController alloc] initWithRootViewController:[[ThirdViewController alloc] init]];
    navOne.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"风景" image:nil tag:0];
    navTwo.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"地球" image:nil tag:1];
    navOne.hidesBottomBarWhenPushed = YES;
    navTwo.hidesBottomBarWhenPushed = YES;
    tabBarViewController.viewControllers = @[navOne, navTwo];
    
    // 初始化XYSideViewController 设置为window.rootViewController
    XYSideViewController *rootViewController = [[XYSideViewController alloc] initWithSideVC:leftViewController currentVC:tabBarViewController];
    self.window.rootViewController = rootViewController;

    return YES;
}

@end
