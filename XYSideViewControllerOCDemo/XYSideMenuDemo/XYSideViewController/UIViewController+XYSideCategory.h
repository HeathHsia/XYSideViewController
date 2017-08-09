//
//  UIViewController+XYSideCategory.h
//  XYSideMenuDemo
//
//  Created by FireHsia on 2017/8/8.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYSideViewController;

@interface UIViewController (XYSideCategory)

/**
    获取XYSideViewController
 */
@property (nonatomic, strong, readonly)XYSideViewController *sideViewController;
/**
    左侧VC push操作
 */
- (void)XYSidePushViewController:(UIViewController *)viewController animated:(BOOL)animated;
/**
    打开侧拉栏
 */
- (void)XYSideOpenVC;

@end
