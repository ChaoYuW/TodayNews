//
//  UIViewController+ECExtension.swift
//  TodayNews
//
//  Created by chao on 2021/1/14.
//  Copyright © 2021 chao. All rights reserved.
//

import UIKit


extension UIViewController {
    
    public func ec_visibleViewControllerIfExist() -> UIViewController? {
        if self.presentedViewController != nil {
            return self.presentedViewController?.ec_visibleViewControllerIfExist()
        }
        
        if self.isKind(of: UINavigationController.classForCoder()) {
            let navVC = self as? UINavigationController
            
            return navVC?.visibleViewController?.ec_visibleViewControllerIfExist()
        }
        
        if self.isKind(of: UITabBarController.classForCoder()) {
            let tabbarVC = self as? UITabBarController
            return tabbarVC?.selectedViewController?.ec_visibleViewControllerIfExist()
        }
        
        if self.isViewLoaded && self.view.window != nil {
            return self
        }else {
            print("找不到可见的控制器，viewController.self=\(self)，self.view.window=\(String(describing: self.view.window))")
            return nil
        }
    }
    
}
