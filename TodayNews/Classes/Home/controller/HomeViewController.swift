//
//  HomeViewController.swift
//  TodayNews
//
//  Created by chao on 2020/9/10.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
import JXSegmentedView
import HandyJSON

class HomeViewController: YDBaseViewController {

    lazy private var searchBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: SCREEN_WIDTH - adaptSize(20) - adaptSize(31), y: (44-adaptSize(31))*0.5, width: adaptSize(31), height: adaptSize(31))
        btn.setImage(UIImage(named: "nav_search_icon"), for: .normal)
        btn.addTarget(self, action: #selector(searchClick(_:)), for: .touchUpInside)
        
        return btn
    }()
    lazy private var scanBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: SCREEN_WIDTH - adaptSize(20) - adaptSize(31), y: (44-adaptSize(31))*0.5, width: adaptSize(31), height: adaptSize(31))
        btn.setImage(UIImage(named: "nav_search_icon"), for: .normal)
        btn.addTarget(self, action: #selector(scanClick(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.gk_navBarAlpha = 0
        
        let navView = UIView(frame: CGRect(x: 0, y: NAVBAR_HEIGHT-44, width: SCREEN_WIDTH, height: 44))
        
        self.gk_navigationBar.addSubview(navView)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func searchClick(_ button :UIButton){
        
    }
    @objc func scanClick(_ button :UIButton){
        
    }
}

