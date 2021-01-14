//
//  UIDevice-iphoneX.swift
//  TodayNews
//
//  Created by chao on 2020/12/22.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit

extension UIDevice {
    public func isIphoneX() -> Bool {
        if #available(iOS 11.0, *) {
            let keyWinwow = getKeyWindow()
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
    
    
    public func getKeyWindow() -> UIWindow? {
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
}
