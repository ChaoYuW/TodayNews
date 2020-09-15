//
//  ECMyTabBarController.swift
//  TodayNews
//
//  Created by chao on 2020/9/10.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit

class ECMyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addChildViewControllers()
        
    }
    
    //添加子控制器
    private func addChildViewControllers()
    {
        setChildViewController(HomeViewController(), title: "首页", imageName: "home")
        setChildViewController(InformationViewController(), title: "新闻", imageName: "information")
        setChildViewController(LivingViewController(), title: "直播", imageName: "live")
    }
    private func setChildViewController(_ childController: UIViewController, title: String, imageName: String)
    {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        childController.title = title;
        addChild(ECMyNavigationController(rootViewController: childController))
    }
}
