# XYSideViewController

一个侧拉菜单控制器(仿QQ侧拉栏)

**Email : firehsia1204@gmail.com**

**欢迎邮件 欢迎Star** 

![demoGif](demoGif.gif)

## Installation

1. 直接将XYSideViewController文件夹放入到工程即可使用

2. cocopods
 
 > pod 'XYSideViewController', '~> 1.0.1'
 
##OC版本

1. 初始化```XYSideViewController```作为```window.rootViewController```
 
```
XYSideViewController *rootViewController = [[XYSideViewController alloc] initWithSideVC:leftViewController currentVC:tabBarViewController];
self.window.rootViewController = rootViewController;
```

> SideVC :  左侧控制器
>  
> currentVC : 主控制器
 
2. 侧拉栏属性
 
  > - sideContentOffset 可侧拉最大偏移量 默认3/4 * 屏幕宽
  > - currentVCPanEnableRange pan侧拉手势范围  默认50
  > - isSide 侧拉开关 默认开启
  > - currentNavController 获取主VC当前的导航控制器(用于左侧控制器跳转)
  > - - (void)closeSideVC 关闭侧拉栏
  > - - (void)openSideVC 打开侧拉栏
  
3. UIViewController+XYSideCategory
  > - sideViewController 获取侧拉控制器
  > - ```- (void)XYSidePushViewController:(UIViewController *)viewController animated:(BOOL)animated``` 
  左侧控制器push
  > - ```- (void)XYSideOpenVC``` 打开侧拉栏
  
##Swift版本

稍后补上