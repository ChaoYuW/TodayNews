//
//  ECMyNavigationController.swift
//  TodayNews
//
//  Created by chao on 2020/9/10.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit

class ECMyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = UIColor.white;
        navigationBar.tintColor = UIColor.white
//        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
    }
    
    

    deinit {
        
    }

}
