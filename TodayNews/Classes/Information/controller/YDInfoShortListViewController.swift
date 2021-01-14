//
//  YDInfoShortListViewController.swift
//  TodayNews
//
//  Created by chao on 2021/1/14.
//  Copyright © 2021 chao. All rights reserved.
//

import UIKit
import JXSegmentedView
import MJRefresh

class YDInfoShortListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    weak var delegate : LoadDataDelegate?
    var dataMuAry = [YDContentModel]()
    var reqParam = YDReqModel()
    var pageIndex : Int = 1
    
    static let colId = "InfoShortVideoCollectionViewCell"
    
    lazy var myCollectView : UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        let co_w = (SCREEN_WIDTH-1)*0.5
        let co_h = co_w*1.5
        flowLayout.itemSize = CGSize(width: (SCREEN_WIDTH-1)/2, height: co_h)
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "InfoShortVideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: YDInfoShortListViewController.colId)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return collectionView
    } ()
    
    var _isNoMoreData :Bool = false
    
    var isNoMoreData : Bool {
        set {
            _isNoMoreData = newValue
            if _isNoMoreData {
                myCollectView.mj_footer?.endRefreshingWithNoMoreData()
            }else{
                myCollectView.mj_footer?.resetNoMoreData()
            }
        }
        get {
            return _isNoMoreData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(myCollectView)
        
        self.addRefreshForView(scrollView: myCollectView)
        // Do any additional setup after loading the view.
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
            if ((myCollectView.mj_header?.isRefreshing) != nil) {
                myCollectView.mj_header?.endRefreshing()
            }
           
        }else
        {
            if ((myCollectView.mj_footer?.isRefreshing) != nil) {
                myCollectView.mj_footer?.endRefreshing()
            }
            
        }
        
        myCollectView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataMuAry.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YDInfoShortListViewController.colId, for: indexPath) as! InfoShortVideoCollectionViewCell
        
        let model = dataMuAry[indexPath.item]
        cell.model = model
        return cell
        
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}






extension YDInfoShortListViewController: JXSegmentedListContainerViewListDelegate
{
    func listView() -> UIView {
        return view
    }
    func listDidAppear() {
        
    }
}
