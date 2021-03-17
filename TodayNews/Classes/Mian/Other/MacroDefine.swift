//
//  MacroDefine.swift
//  TodayNews
//
//  Created by chao on 2020/9/11.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
//import <#module#>



// 屏幕的宽
let SCREEN_WIDTH = UIScreen.main.bounds.width
// 屏幕的高
let SCREEN_HEIGHT = UIScreen.main.bounds.height



let MENU_HEIGHT = 50.0

//判断是否iphoneX
let IS_IPHONEX = ECConfigure.isIphoneX()
let NAVBAR_HEIGHT = IS_IPHONEX ? CGFloat(88.0) : CGFloat(64.0)
let TABBAR_HEIGHT = IS_IPHONEX ? CGFloat(49.0+34.0) : CGFloat(49.0)
let CONTENT_HEIGHT = (SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT)
let STATUSBAR_HEIGHT = IS_IPHONEX ? CGFloat(44.0) : CGFloat(20.0)
public let GK_SAFEAREA_TOP: CGFloat = ECConfigure.safeAreaInsets().top
public let GK_SAFEAREA_BTM: CGFloat = ECConfigure.safeAreaInsets().bottom

// 字符串定义
let kMainControllerInitSuccessNotiKey = "kMainControllerInitSuccessNotiKey"



// 是否是iPad
public let IS_IPAD: Bool = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)


// 颜色
func COLOR_RGBA(r:CGFloat,g:CGFloat,b:CGFloat, alpha:CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: alpha)
}
func COLOR_16(h:Int) -> UIColor
{
    return COLOR_RGBA(r: CGFloat(((h)>>16) & 0xFF), g: CGFloat(((h)>>8) & 0xFF), b: CGFloat((h) & 0xFF), alpha: 1.0)
}
func RANDOM_COLOR() -> UIColor {
    return COLOR_RGBA(r: (((CGFloat)((arc4random() % 256)) / 255.0)), g: (((CGFloat)((arc4random() % 256)) / 255.0)), b: (((CGFloat)((arc4random() % 256)) / 255.0)), alpha: 1.0)
}
let main_bg_color = COLOR_RGBA(r: 242, g: 242, b: 242, alpha: 1)
let deputy_bg_color = COLOR_RGBA(r: 242, g: 242, b: 242, alpha: 1)

//字体大小
var kFont : (CGFloat) -> UIFont = {size in
    return UIFont.systemFont(ofSize: size)
}
func adaptSize(_ value : CGFloat) -> CGFloat {
    let screen_w = UIScreen.main.bounds.width
    return value*(screen_w/414.0)
}

