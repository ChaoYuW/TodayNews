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
        var isIphoneX : Bool = false
        if #available(iOS 11.0, *) {
            isIphoneX = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! > 0.0
        }
        return isIphoneX
    }
}
