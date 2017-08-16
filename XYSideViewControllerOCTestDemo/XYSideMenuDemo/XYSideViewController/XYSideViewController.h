//
//  XYSideViewController.h
//  XYSideMenuDemo
//
//  Created by FireHsia on 2017/8/8.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSideViewController : UIViewController

/**
    侧拉控制器初始化方法
    @param sideMenuVC 左侧侧拉VC
    @param currentMainVC 当前主VC
 */
- (instancetype)initWithSideVC:(UIViewController *)sideMenuVC currentVC:(UIViewController *)currentMainVC;
/**
    侧拉菜单VC
 */
@property (nonatomic, strong) UIViewController *sideVC;
/**
    主VC
 */
@property (nonatomic, strong) UIViewController *currentVC;
/**
    侧拉偏移量
    默认 3/4 * 屏幕宽
 */
@property (nonatomic, assign) CGFloat sideContentOffset;
/**
    主VC Pan手势的范围
    默认 50
 */
@property (nonatomic, assign) CGFloat currentVCPanEnableRange;
/**
    侧拉开关
    默认 开启
 */
@property (nonatomic, assign) BOOL isSide;
/**
    获取主VC当前的导航控制器
    用于侧拉VC 跳转
 */
@property (nonatomic, readonly, strong) UINavigationController *currentNavController;
/**
    关闭侧拉栏
 */
- (void)closeSideVC;
/**
    打开侧拉栏
 */
- (void)openSideVC;

@end
