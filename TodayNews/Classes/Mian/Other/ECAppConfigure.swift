//
//  ECAppConfigure.swift
//  TodayNews
//
//  Created by chao on 2021/1/14.
//  Copyright © 2021 chao. All rights reserved.
//

import UIKit

public let ECConfigure = ECAppConfigure.shared
open class ECAppConfigure: NSObject {

    // 单例
    public static let shared: ECAppConfigure = {
        let instance = ECAppConfigure()
        // setup code
        return instance
    }()
    /// 设置默认配置
    open func setupDefault() {
        
    }
    open func isIphoneX() -> Bool {
        if #available(iOS 11.0, *) {
            let keyWinwow = ECConfigure.getKeyWindow()
            if let window = keyWinwow {
                return window.safeAreaInsets.bottom > 0 ? true : false
            }
        }
        // 当iOS11以下或获取不到keyWindow时用以下方案
        let screenSize = UIScreen.main.bounds.size
        return ((UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 375, height:812), screenSize) : false) ||
                (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 812, height:375), screenSize) : false) ||
                (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 414, height:896), screenSize) : false) ||
                (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 896, height:414), screenSize) : false) ||
                (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 390, height:844), screenSize) : false) ||
                (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 844, height:390), screenSize) : false) ||
                (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 428, height:926), screenSize) : false) ||
                (UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 926, height:428), screenSize) : false))
    }
    open func safeAreaInsets() -> UIEdgeInsets {
        var safeAreaInsets = UIEdgeInsets.zero
        if #available(iOS 11.0, *) {
            let keyWindow = ECConfigure.getKeyWindow()
            if let window = keyWindow {
                safeAreaInsets = window.safeAreaInsets
            }else { // 如果获取到的window是空
                // 对于刘海屏，当window没有创建的时候，可根据状态栏设置安全区域顶部高度
                // iOS14之后顶部安全区域不再是固定的44，所以修改为以下方式获取
                if ECConfigure.isIphoneX() {
                    safeAreaInsets = UIEdgeInsets(top: ECConfigure.statusBarFrame().size.height, left: 0, bottom: 34, right: 0)
                }
            }
        }
        return safeAreaInsets
    }
    open func statusBarFrame() -> CGRect {
        return UIApplication.shared.statusBarFrame
    }
    open func getKeyWindow() -> UIWindow? {
        var window: UIWindow?
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        }
        
        if window == nil {
            window = UIApplication.shared.windows.first { $0.isKeyWindow }
            if window == nil {
                window = UIApplication.shared.keyWindow
            }
        }
        
        return window
    }
    
    func currentNavViewController() -> UINavigationController? {
        var n: UINavigationController?
        while n != nil {
            if let nav = n
            {
                return nav
            }
            n = n?.next as? UINavigationController
        }
        return nil

    }
    func currentViewController() -> UIViewController? {
        let keyWinwow = ECConfigure.getKeyWindow()
        var topVC = keyWinwow!.rootViewController
        while true {
            if let vc = topVC?.presentedViewController {
                topVC = vc.presentedViewController
            }
            else if let tab = topVC as? UITabBarController {
                topVC = tab.selectedViewController
            }
            else if let nav = topVC as? UINavigationController
            {
                topVC = nav.topViewController
            }else
            {
                break
            }
        }
        return topVC
    }

}
