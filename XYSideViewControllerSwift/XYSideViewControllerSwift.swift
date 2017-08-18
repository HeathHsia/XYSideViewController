//
//  XYSideViewControllerSwift.swift
//  XYSideViewControllerSwiftDemo
//
//  Created by kaopuniao on 2017/8/17.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

import UIKit

class XYSideViewControllerSwift: UIViewController {
    
    var sideVC : UIViewController
    var currentVC : UIViewController
    var currentVCPanEnableRange : CGFloat
    var isSide : Bool = true
    var currentNavController : UINavigationController? {
        get {
            return getCurrentNavtion()
        }
    }
    fileprivate var sideContentOffset : CGFloat
    fileprivate let XYScreenWidth = UIScreen.main.bounds.size.width
    fileprivate let XYScreenHeight = UIScreen.main.bounds.size.height
    
    init(_ sideMenuVC : UIViewController, _ currentMainVC : UIViewController) {
        sideVC = sideMenuVC
        currentVC = currentMainVC
        currentVCPanEnableRange = 100
        sideContentOffset = XYScreenWidth * 3 / 4
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViewController()
    }
    
    // MARK : - setUpVCs
    fileprivate func setUpViewController() {
        self.addChildViewController(sideVC)
        sideVC.view.center = CGPoint(x: view.center.x - (sideContentOffset / 2), y: view.center.y)
        sideVC.view.bounds = CGRect(x: 0, y: 0, width: XYScreenWidth, height: XYScreenHeight)
        view.addSubview(sideVC.view)
        
        currentVC.view.frame = CGRect(x: 0, y: 0, width: XYScreenWidth, height: XYScreenHeight)
        currentVC.view.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.new , context: nil)
        let panGesure = UIPanGestureRecognizer(target: self, action: #selector(panGesure(_:)))
        currentVC.view.addGestureRecognizer(panGesure)
        panGesure.delegate = self;
        currentVC.view.addSubview(tapView)
        view.addSubview(currentVC.view)
    }
    
    // MARK : - 关闭侧拉菜单
    func closeSideVC() {
        UIView.animate(withDuration: 0.2, animations: { [unowned self] in
            self.currentVC.view.center = self.view.center
            var point = self.view.center
            point.x = point.x - (self.sideContentOffset / 2)
            self.sideVC.view.center = point
        }) { (isFinished) in
            self.beginPoint = self.currentVC.view.center
            self.beginSidePoint = self.sideVC.view.center
        }
    }
    
    // MARK : - 打开侧拉菜单
    func openSideVC() {
        UIView.animate(withDuration: 0.2, animations: { [unowned self] in
            var point = self.view.center
            point.x = self.viewStartCenterPoint.x + self.sideContentOffset
            self.currentVC.view.center = point
            self.sideVC.view.center = self.view.center
        }) { (isFinished) in
            self.beginPoint = self.currentVC.view.center
            self.beginSidePoint = self.sideVC.view.center
        }
    }

    // MARK : - 手势方法
    @objc fileprivate func tapGesure(_ tap : UITapGestureRecognizer) {
        closeSideVC()
    }
    
    @objc fileprivate func panGesure(_ pan : UIPanGestureRecognizer) {
        guard (isPushViewController() && isSide) else { return }
        let point = pan.velocity(in: currentVC.view)
        let movePoint = pan.translation(in: currentVC.view)
        let tabBarCenterPoint = currentVC.view.center
        if pan.state == UIGestureRecognizerState.changed {
            // 手势滑动时改变侧拉VC和主VC的center
            var tabBarVCCenter = beginPoint
            var sideVCCenter = beginSidePoint
            tabBarVCCenter.x = beginPoint.x + movePoint.x
            sideVCCenter.x = beginSidePoint.x + ((movePoint.x * (sideContentOffset / 2)) / sideContentOffset)
            if tabBarVCCenter.x >= viewStartCenterPoint.x && (viewStartCenterPoint.x + sideContentOffset) >= tabBarVCCenter.x{
                currentVC.view.center = tabBarVCCenter
                sideVC.view.center = sideVCCenter
            }else if viewStartCenterPoint.x > tabBarVCCenter.x {
                currentVC.view.center = view.center
                var point = view.center
                point.x = point.x - (sideContentOffset / 2)
                sideVC.view.center = point
            }else if tabBarVCCenter.x > (viewStartCenterPoint.x + sideContentOffset) {
                var point = view.center
                point.x = viewStartCenterPoint.x + sideContentOffset
                currentVC.view.center = point
                sideVC.view.center = view.center
            }
        }else if pan.state == UIGestureRecognizerState.ended {
            // 根据手势停止的位置决定关闭/开启侧拉VC
            let changeX = fabs(point.x)
            let changeY = fabs(point.y)
            if changeX > changeY && changeX > 50 {
                if point.x > 0 {
                    openSideVC()
                }else {
                    closeSideVC()
                }
            }else {
                if tabBarCenterPoint.x > view.center.x && (view.center.x + (sideContentOffset / 2)) >= tabBarCenterPoint.x {
                    closeSideVC()
                }else if tabBarCenterPoint.x > (view.center.x + sideContentOffset / 2) && (view.center.x + sideContentOffset) >= tabBarCenterPoint.x {
                    openSideVC()
                }
            }
        }
    }
    
    // MARK : - 判断currentVC导航控制器是否位于根控制器
    fileprivate func isPushViewController() -> Bool {
        let arr : Array<UIViewController>? = getCurrentNavtion()?.viewControllers
        if arr?.count == 1 {
            return true
        }else {
            return false
        }
    }
    
    // MARK : - 获取当前导航控制器
    fileprivate func getCurrentNavtion() -> UINavigationController? {
        var currentNavVC : UINavigationController?
        if let tabBarVC = currentVC as? UITabBarController  {
            var vcArray = tabBarVC.viewControllers
            let navC = vcArray?[tabBarVC.selectedIndex]
            if let navVC = navC as? UINavigationController {
                currentNavVC = navVC
            }
        }else if let navVC = currentVC as? UINavigationController {
            currentNavVC = navVC
        }
        return currentNavVC
    }
    
    // MARK : - 懒加载
    lazy var beginSidePoint : CGPoint = { [unowned self] in
        var point : CGPoint = self.view.center
        point.x = point.x - self.sideContentOffset / 2;
        return point
    }()
    
    lazy var beginPoint : CGPoint = { [unowned self] in
        var point : CGPoint = self.view.center
        return point
    }()
    
    lazy var viewStartCenterPoint : CGPoint = { [unowned self] in
        var point : CGPoint = self.view.center
        return point
    }()
    
    lazy var tapView : UIView = { [unowned self] in
        var tap_view = UIView()
        tap_view.frame = CGRect(x: 0, y: 0, width: self.XYScreenWidth - self.sideContentOffset, height: self.XYScreenHeight)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesure(_:)))
        tap_view.addGestureRecognizer(tapGesture)
        tap_view.isHidden = true
        return tap_view
    }()
}

extension XYSideViewControllerSwift : UIGestureRecognizerDelegate {
    
    // MARK : - 手势代理方法
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let beginPointInView = touch.location(in: currentVC.view)
        if (gestureRecognizer is UIPanGestureRecognizer) && (XYScreenHeight - 49) >= beginPointInView.y {
            if beginPointInView.x < currentVCPanEnableRange {
                return isPushViewController()
            }else {
                return false
            }
        }
        return false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "center" {
            if let centerpoint = change?[NSKeyValueChangeKey.newKey] {
                if let centerpointValue = centerpoint as? NSValue {
                    let point = centerpointValue.cgPointValue
                    if point.x == (viewStartCenterPoint.x + sideContentOffset) {
                        tapView.isHidden = false
                    }else {
                        tapView.isHidden = true
                    }
                }
            }
        }
    }
    
}
