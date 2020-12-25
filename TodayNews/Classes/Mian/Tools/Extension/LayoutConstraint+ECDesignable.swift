//
//  LayoutConstraint+ECDesignable.swift
//  TodayNews
//
//  Created by chao on 2020/12/25.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit


private var AdapterScreenKey = "AdapterScreenKey"

extension NSLayoutConstraint
{
    @IBInspectable var adapterScreen : Bool  {
        set {
            objc_setAssociatedObject(self, &AdapterScreenKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            if newValue {
                self.constant = adaptSize(value: self.constant)
            }
        }
        get {
            if let ad = objc_getAssociatedObject(self, AdapterScreenKey) as? Bool {
                return ad
            }
            return false
        }
    }
    
    func adaptSize(value : CGFloat) -> CGFloat {
        
        let screen_w = UIScreen.main.bounds.width
        return value*(screen_w/414.0)
    }
}

