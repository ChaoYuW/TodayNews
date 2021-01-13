//
//  InformationTableViewController.swift
//  TodayNews
//
//  Created by chao on 2020/9/11.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
import JXSegmentedView
import MJRefresh


protocol LoadDataDelegate : NSObjectProtocol{
    
    func loadPageIndex(_ pageIndex : NSInteger)
}

class InformationTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    weak var delegate : LoadDataDelegate?
    var dataMuAry = [YDContentModel]()
    var reqParam = YDReqModel()
    var pageIndex : Int = 1
    
    var _isNoMoreData :Bool = false
    
    var isNoMoreData : Bool {
        set {
            _isNoMoreData = newValue
            if _isNoMoreData {
                myTableView.mj_footer?.endRefreshingWithNoMoreData()
            }else{
                myTableView.mj_footer?.resetNoMoreData()
            }
        }
        get {
            return _isNoMoreData
        }
    }
    
    

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
        
        self.addRefreshForView(scrollView: myTableView)
    }
    public func addRefreshForView(scrollView : UIScrollView)
    {
        self.headerRefresh(scrollView: scrollView)
        self.footerRefresh(scrollView: scrollView)
    }
    public func headerRefresh(scrollView : UIScrollView)
    {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefreshloadData))
        header.lastUpdatedTimeLabel?.font = UIFont.systemFont(ofSize: 12)
        header.stateLabel?.font = UIFont.systemFont(ofSize: 12)
        header.setTitle("", for: .idle)
        header.setTitle("松开进行刷新...", for: .pulling)
        header.setTitle("正在刷新...", for: .refreshing)
        if #available(iOS 13.0, *) {
            header.loadingView?.style = .large
            header.loadingView?.color = .white
        }else
        {
            header.activityIndicatorViewStyle = .white
        }
        
        header.lastUpdatedTimeLabel?.isHidden = true
        scrollView.mj_header = header
    }
    public func footerRefresh(scrollView : UIScrollView)
    {
        let footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(footerRefreshloadData))
        scrollView.mj_footer = footer
    }
    
    @objc func headerRefreshloadData() -> Void {
        print("头刷新")
        pageIndex = 1
        delegate?.loadPageIndex(pageIndex)
    }
    @objc func footerRefreshloadData() -> Void {
        print("加载更多")
        pageIndex = pageIndex + 1
        delegate?.loadPageIndex(pageIndex)
    }
    public func reloadData()
    {
        if pageIndex == 1 {
            if ((myTableView.mj_header?.isRefreshing) != nil) {
                myTableView.mj_header?.endRefreshing()
            }
           
        }else
        {
            if ((myTableView.mj_footer?.isRefreshing) != nil) {
                myTableView.mj_footer?.endRefreshing()
            }
            
        }
        
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMuAry.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataMuAry[indexPath.row]
        if model.displayStyle == "multi-image" {
            return model.cellHeight
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = dataMuAry[indexPath.row]
        switch model.displayStyle {
        case "plain-text": //@"plain-text"//:               无图，纯文本
            let cell = YDLeftImageTableViewCell.cellWithTableView(tableView: tableView)
            let model = dataMuAry[indexPath.row]
            
            cell.model = model
            return cell
        case "inline-image": //: 1张小图（放左侧）
            let cell = YDLeftImageTableViewCell.cellWithTableView(tableView: tableView)
            let model = dataMuAry[indexPath.row]
            
            cell.model = model
            return cell
        case "v-image":  //1张竖图
            let cell = YDLeftImageTableViewCell.cellWithTableView(tableView: tableView)
            let model = dataMuAry[indexPath.row]
            
            cell.model = model
            return cell
        case "multi-image":  //多张横图
            let cell = YDMultiImageTableViewCell.cellWithTableView(tableView: tableView)
            let model = dataMuAry[indexPath.row]
            
            cell.model = model
            return cell
            
        default:
            let cell = YDLeftImageTableViewCell.cellWithTableView(tableView: tableView)
            let model = dataMuAry[indexPath.row]
            
            cell.model = model
            return cell
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
