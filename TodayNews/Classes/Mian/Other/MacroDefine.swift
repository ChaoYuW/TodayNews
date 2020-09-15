//
//  MacroDefine.swift
//  TodayNews
//
//  Created by chao on 2020/9/11.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit

// 屏幕的宽
let SCREEN_WIDTH = UIScreen.main.bounds.width
// 屏幕的高
let SCREEN_HEIGHT = UIScreen.main.bounds.height
//状态栏高度
let STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.height
//导航栏高度:通用
let NAVIGATIONBAR_HEIGHT = UINavigationController().navigationBar.frame.size.height

let CATEGORY_HEIGHT = 50.0

//判断是否iphoneX
let W_IPHONEX = (CGFloat(SCREEN_WIDTH) == CGFloat(375.0) && CGFloat(SCREEN_HEIGHT) == CGFloat(812.0)) ? true : false
let W_NAVBARHEIGHT = W_IPHONEX ? CGFloat(88.0) : CGFloat(64.0)
let W_TABBARHEIGHT = W_IPHONEX ? CGFloat(49.0+34.0) : CGFloat(49.0)
let W_STATUSBARHEIGHT = W_IPHONEX ? CGFloat(44.0) : CGFloat(20.0)


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

