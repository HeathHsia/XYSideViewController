//
//  UIViewController+XYSideCategory.m
//  XYSideMenuDemo
//
//  Created by FireHsia on 2017/8/8.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

#import "UIViewController+XYSideCategory.h"
#import "XYSideViewController.h"

@implementation UIViewController (XYSideCategory)

- (XYSideViewController *)sideViewController
{
    return (XYSideViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
}

- (void)XYSidePushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.sideViewController closeSideVC];
    [self.sideViewController.currentNavController pushViewController:viewController animated:animated];
}

- (void)XYSideOpenVC
{
    [self.sideViewController openSideVC];
}
@end
