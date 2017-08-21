![XYSideViewController](icon.png)

[![platform](http://img.shields.io/badge/platform-iOS-orange.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-ObjC&Swift-brightgreen.svg?style=flat)](https://developer.apple.com/documentation/)
![version](http://img.shields.io/badge/version-1.0.2-00FFFF.svg?style=flat)
[![blog](http://img.shields.io/badge/jianshu-简书-FF00FF.svg?style=flat)](http://www.jianshu.com/u/eec143f2560d)
[![License](http://img.shields.io/badge/license-MIT-ff69b4.svg?style=flat)](http://mit-license.org)

## XYSideViewController
一个侧拉菜单控制器(仿QQ侧拉栏)

**Email : firehsia1204@gmail.com**

**欢迎Issue 欢迎邮件 欢迎Star** 

![demoGif](demoGif.gif)

## Installation

1. OC版本 
 
		直接将XYSideViewControllerOC文件夹放入到工程即可使用
	
	Swift版本
	
		直接将XYSideViewControllerSwift文件夹放入到工程即可使用

2. cocopods
 
 > pod 'XYSideViewController', '~> 1.0.3'
 
 > 注: 请在PodFile 后面添加 use_frameworks!
 
 >  若找不到该库 请先执行 `pod repo update`  再 `pod install`
 
 
## OC版本

1. 初始化```XYSideViewController```作为```window.rootViewController```
 
	```
	XYSideViewController *rootViewController = [[XYSideViewController alloc] initWithSideVC:leftViewController currentVC:tabBarViewController];
	self.window.rootViewController = rootViewController;
	```
	
	- SideVC :  左侧控制器
	 
	- currentVC : 主控制器
 
2. 侧拉栏属性
 
   - sideContentOffset 
    
  		- 可侧拉最大偏移量  
  		
  		- 默认值:  3/4 * 屏幕宽
   - currentVCPanEnableRange
     
  		- pan侧拉手势范围  
 	  
  		- 默认值: 50
   - isSide 
    
   		- 侧拉开关
   		
   		- 默认值: 开启
   - currentNavController

     	- 获取主VC当前的导航控制器
     
   - (void)closeSideVC 
    
     	- 关闭侧拉栏
   - (void)openSideVC 

   		- 打开侧拉栏
  
3. UIViewController+XYSideCategory
   - sideViewController 
    
   		- 获取侧拉控制器
   - ```- (void)XYSidePushViewController:(UIViewController *)viewController animated:(BOOL)animated``` 
  
 	 	- 左侧控制器push
   - ```- (void)XYSideOpenVC``` 

   		- 打开侧拉栏
  
  
## Swift版本
1. 初始化
 
	 ```
	 let rootVC = XYSideViewControllerSwift(sideVC, currentMainVC)
	  
	 window?.rootViewController = rootVC 
	 ```

2. 属性和方法
   - currentVCPanEnableRange
     
  		- pan侧拉手势范围  
 	  
  		- 默认值: 50
   - isSide 
    
   		- 侧拉开关
   		
   		- 默认值: 开启
   - currentNavController

     	- 获取主VC当前的导航控制器
     
   - closeSideVC() 
    
     	- 关闭侧拉栏
   - openSideVC()

   		- 打开侧拉栏


