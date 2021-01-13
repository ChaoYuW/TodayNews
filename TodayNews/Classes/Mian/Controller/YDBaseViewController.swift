//
//  YDBaseViewController.swift
//  TodayNews
//
//  Created by chao on 2021/1/13.
//  Copyright © 2021 chao. All rights reserved.
//

import UIKit
import GKNavigationBarSwift

class YDBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.gk_statusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.gk_statusBarStyle
    }

}
