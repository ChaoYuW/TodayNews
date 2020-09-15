//
//  AppDelegate.swift
//  TodayNews
//
//  Created by chao on 2020/9/10.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
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

        NetworkTool.makePostRequest(urlPath: news_channel_listUrl, parameters: muDic, successHandler: { (json) in
            print(json)
        }, errorMsgHandler: { (str) in
            print(str)
        }) { (error) in
            print(error)
        }
        return true
    }



}

