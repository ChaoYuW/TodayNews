//
//  UIKit+Extension.swift
//  TodayNews
//
//  Created by chao on 2020/12/31.
//  Copyright © 2020 chao. All rights reserved.
//

import Foundation
import UIKit



extension UIColor {
    
    class func COLOR_RGBA(r:CGFloat,g:CGFloat,b:CGFloat, alpha:CGFloat) -> UIColor {
        return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: alpha)
    }
    class func mainBackgroundColor() -> UIColor {
        return UIColor.COLOR_RGBA(r: 248, g: 249, b: 247, alpha: 1)
    }
    
    
}
