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

class HomeViewController: UIViewController {

    private var segmentedDataSource: JXSegmentedTitleDataSource!
    private var menuList = [YDChannelModel]()
    private var tempVc = InformationTableViewController()
    
    
    
    lazy private var categoryTitleView: JXSegmentedView = {
        let segmentView = JXSegmentedView()
        segmentView.backgroundColor = UIColor.white
        //2、配置数据源
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentView.dataSource = segmentedDataSource
        segmentView.delegate = self
        
        //3、配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.lineStyle = .lengthen
        segmentView.indicators = [indicator]
        
        return segmentView
    }()
    lazy private var listContainerView : JXSegmentedListContainerView! = {
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        return listContainerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(categoryTitleView)
        view.addSubview(listContainerView)
        
        requestMenuData();
        
    }
    override func viewDidLayoutSubviews() {
        categoryTitleView.frame = CGRect(x: 0, y: NAVBAR_HEIGHT, width: SCREEN_WIDTH, height: CGFloat(MENU_HEIGHT))
        
        listContainerView.frame = CGRect(x: 0, y:categoryTitleView.frame.maxY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-categoryTitleView.frame.maxY-TABBAR_HEIGHT)
        
    }
    
    func requestMenuData() {
        HttpRequest.request(methodType: .POST, urlString: news_channel_listUrl, param: nil) { (retult) in
            
            let list = retult["data"] as! Array<Any>
            var titles = [String]()
            
            if self.menuList.count > 0
            {
                self.menuList.removeAll()
            }
            
            for i in 0 ..< list.count{
                let dict = list[i];
                if let model = JSONDeserializer<YDChannelModel>.deserializeFrom(dict: dict as? [String:Any]) {
                    self.menuList.append(model)
                    titles.append(model.title)
                }
            }
            self.segmentedDataSource.titles = titles
            self.categoryTitleView.dataSource =  self.segmentedDataSource
            var page = 0
            if titles.count > 1{
                page = 1
            }
            self.categoryTitleView.defaultSelectedIndex = page
            self.listContainerView.defaultSelectedIndex = page
            self.categoryTitleView.reloadData()
            self.listContainerView.reloadData()
    
//            guard self.menuList.count > page  else {
//                return
//            }
//            let menu1 = self.menuList[page]
//            
//            self.requestListPageIndex(pageIndex: 1)
        };
    }
    
    func requestListPageIndex(pageIndex : Int) {
        
        let selectIndex = self.categoryTitleView.selectedIndex
        let channel = self.menuList[selectIndex]
        let list : Optional<InformationTableViewController>
//        list.reqParam
        let keys = self.listContainerView.validListDict.keys
        
        if keys.contains(selectIndex) {
            list = self.listContainerView.validListDict[selectIndex] as? InformationTableViewController
        }else {
            list = tempVc
        }
        
        var param = [String : Any]()
        
        param["channel"] = ["id":channel.id]
        param["pageNo"] = pageIndex
        param["pageSize"] = 10
        
        
        print("选中 \(selectIndex) \(param) \(String(describing: list))")
        
        HttpRequest.request(methodType: .POST, urlString: news_content_listURL, param: param) { (result) in
            
            guard let dataDict = result["data"] as? [String :Any] else {return}
            guard let dataAry = dataDict["records"] as? Array<Any> else{return}
            
            for dict in dataAry {
                if let model = JSONDeserializer<YDContentModel>.deserializeFrom(dict: dict as? [String:Any]) {
                    list?.dataMuAry.append(model)
                }
                
            }
            list?.reloadData()
        }
    }

//    func getCurrentController(page : Int) -> InformationTableViewController {
//
//        let keys = Array(self.listContainerView.validListDict.keys)
//
//        if keys.contains(Int) {
//
//        }
//        ret
//
//        let list = self.listContainerView.validListDict[self.categoryTitleView.selectedIndex] as? InformationTableViewController
//    }
}

extension HomeViewController : JXSegmentedViewDelegate
{
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        self.listContainerView.didClickSelectedItem(at: index)
    }
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
        self.listContainerView.didClickSelectedItem(at: index)
    }
}
extension HomeViewController : JXSegmentedListContainerViewDataSource
{
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedDataSource.dataSource.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        let vc = InformationTableViewController()
        
        tempVc = vc
        vc.reqParam = YDReqModel();
        requestListPageIndex(pageIndex: 1)
        print("创建 /(index)")
        return vc
    }
    
    
}

