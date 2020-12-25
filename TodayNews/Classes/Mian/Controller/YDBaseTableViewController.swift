//
//  YDBaseTableViewController.swift
//  TodayNews
//
//  Created by chao on 2020/12/25.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit

class YDBaseTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    var dataMuAry = [Any]()

    lazy var myTableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell ()
    }
}
