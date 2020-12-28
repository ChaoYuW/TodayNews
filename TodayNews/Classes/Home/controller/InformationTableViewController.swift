//
//  InformationTableViewController.swift
//  TodayNews
//
//  Created by chao on 2020/9/11.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
import JXSegmentedView

class InformationTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    var dataMuAry = [YDContentModel]()
    var reqParam = YDReqModel()
    

    lazy var myTableView : UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = self.view.bounds
        tableView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        tableView.separatorStyle = .none
        
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.addSubview(myTableView)
        
    
    }
    public func reloadData()
    {
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMuAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = YDLeftImageTableViewCell.cellWithTableView(tableView: tableView)
        let model = dataMuAry[indexPath.row]
        
        cell.model = model as! YDContentModel
        return cell
    }

}

extension InformationTableViewController: JXSegmentedListContainerViewListDelegate
{
    func listView() -> UIView {
        return view
    }
    func listDidAppear() {
        
    }
}
