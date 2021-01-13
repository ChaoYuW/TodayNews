//
//  AppDelegate.swift
//  TodayNews
//
//  Created by chao on 2020/9/10.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
import GKNavigationBarSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GKConfigure.awake()
        
        GKConfigure.setupCustom { (configure) in
            configure.gk_translationX = 15
            configure.gk_translationY = 20
            configure.gk_scaleX = 0.90
            configure.gk_scaleY = 0.92
            configure.gk_navItemLeftSpace = 12.0
            configure.gk_navItemRightSpace = 12.0
            
            configure.shiledItemSpaceVCs = ["TZ"]
            configure.shiledItemSpaceVCs = ["TZ"]
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ECMyTabBarController()
        window?.makeKeyAndVisible()
        
        
        //获取app信息
        let infoDictionary : Dictionary = Bundle.main.infoDictionary!
        //获取当前版本号
        let app_Version = infoDictionary["CFBundleShortVersionString"] as! String
        
        //2.定义可变：用var修饰
        var muDic = Dictionary<String,Any>()
        
//        muDic["appVersion"] = ["name":"iOS","version":app_Version]
//        muDic["string"] = ""
//        muDic["osVersion"] = ["name":UIDevice.current.name,"version":UIDevice.current.systemVersion]
//        muDic["screenHeight"] = SCREEN_HEIGHT
//        muDic["screenWidth"] = SCREEN_WIDTH

        
        return true
    }



}

