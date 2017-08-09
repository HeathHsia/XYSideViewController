//
//  XYSideViewController.m
//  XYSideMenuDemo
//
//  Created by FireHsia on 2017/8/8.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

#import "XYSideViewController.h"

@interface XYSideViewController () <UIGestureRecognizerDelegate>
{
    CGFloat XYScreenWidth; // 屏幕宽度
    CGFloat XYSccreenHeight; // 屏幕高度
    CGPoint viewStartCenterPoint; // self.view.center
    UIViewController *currentVC; // 主VC
    UIViewController *sideVC; // 侧拉VC
    UIView *tapView; // Tap手势View
    CGPoint beginPoint; // 主VC初始center
    CGPoint beginSidePoint; // 侧拉VC初始center
}
@end

@implementation XYSideViewController

- (instancetype)initWithSideVC:(UIViewController *)sideMenuVC currentVC:(UIViewController *)currentMainVC
{
    if (self = [super init]) {
        XYScreenWidth = [UIScreen mainScreen].bounds.size.width;
        XYSccreenHeight = [UIScreen mainScreen].bounds.size.height;
        viewStartCenterPoint = self.view.center;
        currentVC = currentMainVC;
        sideVC = sideMenuVC;
        _sideContentOffset = XYScreenWidth * 3 / 4;
        _currentVCPanEnableRange = 100;
        _isSide = YES;
        beginPoint = self.view.center;
        CGPoint point = self.view.center;
        point.x = point.x - _sideContentOffset;
        beginSidePoint = point;
        [self setUpViewControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setUpViewControllers
{
    [self addChildViewController:sideVC];
    sideVC.view.frame = CGRectMake(-(_sideContentOffset / 2), 0, XYScreenWidth, XYSccreenHeight);
    [self.view addSubview:sideVC.view];
    currentVC.view.frame = CGRectMake(0, 0, XYScreenWidth, XYSccreenHeight);
    [currentVC.view addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [currentVC.view addGestureRecognizer:panGestureRecognizer];
    panGestureRecognizer.delegate = self;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesure:)];
    tapView = [[UIView alloc] init];
    tapView.frame = CGRectMake(0, 0, XYScreenWidth - _sideContentOffset, XYSccreenHeight);
    [tapView addGestureRecognizer:tapGesture];
    tapView.hidden = YES;
    [currentVC.view addSubview:tapView];
    [self.view addSubview:currentVC.view];
}

#pragma mark -- tap 手势, 关闭侧拉栏
- (void)tapGesure:(UITapGestureRecognizer *)tap
{
    [self closeSideVC];
}
#pragma mark -- pan手势 打开侧拉栏, 关闭侧拉栏, tap手势关闭侧拉栏
- (void)panGesture:(UIPanGestureRecognizer *)pan
{
    if (![self isPushViewController] || !_isSide) {
        return ;
    }
    CGPoint point =  [pan velocityInView:currentVC.view];
    CGPoint movePoint = [pan translationInView:currentVC.view];
    CGPoint tabBarCenterPoint = currentVC.view.center;
    if (pan.state == UIGestureRecognizerStateChanged) {
        // 手势滑动时相对改变侧拉VC和主VC的center
        CGPoint tabBarVCCenter = beginPoint;
        CGPoint sideVCCenter = beginSidePoint;
        tabBarVCCenter.x = beginPoint.x + movePoint.x;
        sideVCCenter.x = beginSidePoint.x + ((movePoint.x * (_sideContentOffset / 2)) / _sideContentOffset);
        if (tabBarVCCenter.x >= viewStartCenterPoint.x  && (viewStartCenterPoint.x + _sideContentOffset) >= tabBarVCCenter.x) {
            currentVC.view.center = tabBarVCCenter;
            sideVC.view.center = sideVCCenter;
        }else if (viewStartCenterPoint.x > tabBarVCCenter.x){
            currentVC.view.center = self.view.center;
            CGPoint point = self.view.center;
            point.x = point.x - (_sideContentOffset / 2);
            sideVC.view.center = point;
        }else if (tabBarVCCenter.x > (viewStartCenterPoint.x + _sideContentOffset)) {
            CGPoint point = self.view.center;
            point.x = viewStartCenterPoint.x + _sideContentOffset;
            currentVC.view.center = point;
            sideVC.view.center = self.view.center;
        }
        
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        // 根据手势停止的位置决定关闭/代开侧拉VC
        CGFloat changeX = fabs(point.x);
        CGFloat changeY = fabs(point.y);
        if (changeX > changeY && changeX > 50) {
            if (point.x > 0) {
                [self openSideVC];
            }else {
                [self closeSideVC];
            }
        }else {
            if ((tabBarCenterPoint.x > self.view.center.x) && (self.view.center.x + (_sideContentOffset / 2) >= tabBarCenterPoint.x)) {
                [self closeSideVC];
            }else if (tabBarCenterPoint.x > (self.view.center.x + (_sideContentOffset / 2)) && (self.view.center.x + _sideContentOffset) >= tabBarCenterPoint.x) {
                [self openSideVC];
            }
        }
    }
}

#pragma mark ---- 关闭侧拉栏
- (void)closeSideVC
{
    [UIView animateWithDuration:0.2 animations:^{
        currentVC.view.center = self.view.center;
        CGPoint point = self.view.center;
        point.x = point.x - (_sideContentOffset / 2);
        sideVC.view.center = point;
    }completion:^(BOOL finished) {
        beginPoint = currentVC.view.center;
        beginSidePoint = sideVC.view.center;
    }];
}

#pragma mark ---- 打开侧拉栏
- (void)openSideVC
{
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint point = self.view.center;
        point.x = viewStartCenterPoint.x + _sideContentOffset;
        currentVC.view.center = point;
        sideVC.view.center = self.view.center;
    }completion:^(BOOL finished) {
        beginPoint = currentVC.view.center;
        beginSidePoint = sideVC.view.center;
    }];
}

#pragma mark ---- 手势代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint beginPointInView = [touch locationInView:currentVC.view];
    // 控制pan手势范围
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && ((XYSccreenHeight - currentVC.tabBarController.tabBar.frame.size.height) >= beginPointInView.y)) {
        if (beginPointInView.x < _currentVCPanEnableRange) {
            return [self isPushViewController];
        }else {
            return NO;
        }
    }
    return NO;
}

#pragma mark -- 判断currentVC导航控制器是否位于根控制器
- (BOOL)isPushViewController
{
    NSArray *viewControllers = [[NSArray alloc] init];
    if ([currentVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)currentVC;
        NSArray *navVCs = tabBarVC.viewControllers;
        UINavigationController *naVC = [navVCs objectAtIndex:tabBarVC.selectedIndex];
        viewControllers = naVC.viewControllers;
    }else if ([currentVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navVC = (UINavigationController *)currentVC;
        viewControllers = navVC.viewControllers;
    }
    if (viewControllers.count == 1) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}

#pragma mark --- 监听currentVC.center 隐藏tapView
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"center"]) {
        NSValue *centerPoint =  change[@"new"];
        CGPoint point = [centerPoint CGPointValue];
        if (point.x == (viewStartCenterPoint.x + _sideContentOffset)) {
            tapView.hidden = NO;
        }else {
            tapView.hidden = YES;
        }
    }
}

#pragma mark --- 获取主VC当前的导航控制器
- (UINavigationController *)currentNavController
{
    UINavigationController *currentNavVC = [[UINavigationController alloc] init];
    if ([currentVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navVC = (UINavigationController *)currentVC;
        currentNavVC = navVC;
    }else if ([currentVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)currentVC;
        currentNavVC = tabBarVC.childViewControllers[tabBarVC.selectedIndex];
    }
    return currentNavVC;
}

#pragma mark --- sideContentOffset Setter
- (void)setSideContentOffset:(CGFloat)sideContentOffset
{
    _sideContentOffset = sideContentOffset;
    sideVC.view.frame = CGRectMake(- _sideContentOffset / 2, 0, XYScreenWidth, XYSccreenHeight);
    currentVC.view.frame = CGRectMake(0, 0, XYScreenWidth, XYSccreenHeight);
    tapView.frame = CGRectMake(0, 0, (XYScreenWidth - _sideContentOffset), XYSccreenHeight);
}

#pragma mark ---- 判断滑动方向
- (void)directByPointInVelocity:(CGPoint )point
{
    // 根据x坐标来分析滑动的方向
    CGFloat changeX = fabs(point.x);
    CGFloat changeY = fabs(point.y);
    if (changeX > changeY && changeX > 20) {
        if (point.x > 0) {
        }else {
        }
    }
}

@end
