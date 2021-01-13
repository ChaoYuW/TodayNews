//
//  InformationViewController.swift
//  TodayNews
//
//  Created by chao on 2020/9/10.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
import JXSegmentedView
import HandyJSON

class InformationViewController: YDBaseViewController {

    private var segmentedDataSource: JXSegmentedTitleDataSource!
    private var menuList = [YDChannelModel]()
    private var tempVc : InformationTableViewController?
    private var _selectedIndex : Int = 0
    
    lazy private var topBgImgView : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "info_top_bg"))
        imgView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height:adaptSize(248))
        
        return imgView
    } ()
    
    lazy private var searchBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: SCREEN_WIDTH - adaptSize(20) - adaptSize(31), y: (44-adaptSize(31))*0.5, width: adaptSize(31), height: adaptSize(31))
        btn.setImage(UIImage(named: "nav_search_icon"), for: .normal)
        btn.addTarget(self, action: #selector(searchClick(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    
    lazy private var categoryTitleView: JXSegmentedView = {
        let segmentView = JXSegmentedView()
        segmentView.frame = CGRect(x: adaptSize(20), y: (44-30)*0.5, width: SCREEN_WIDTH-2*2*adaptSize(20), height: 30)
//        segmentView.backgroundColor = UIColor.white
        //2、配置数据源
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.titleSelectedColor = UIColor.white
        segmentedDataSource.titleNormalColor = UIColor.white
        segmentView.dataSource = segmentedDataSource
        segmentView.delegate = self
        
        //3、配置指示器
        
        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.indicatorHeight = adaptSize(30)
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
//        indicator.indicatorWidthIncrement = 0
        indicator.indicatorColor = UIColor.COLOR_RGBA(r: 255, g: 255, b: 255, alpha: 0.2)
        
//        let indicator = JXSegmentedIndicatorLineView()
//        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
//        indicator.lineStyle = .lengthen
        segmentView.indicators = [indicator]
        
        return segmentView
    }()
    lazy private var listContainerView : JXSegmentedListContainerView! = {
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        listContainerView.frame = CGRect(x: 0, y:NAVBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-NAVBAR_HEIGHT-TABBAR_HEIGHT)
        return listContainerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gk_navBarAlpha = 0
        self.gk_navItemLeftSpace = 0
        self.gk_navItemRightSpace = 0
        view.addSubview(topBgImgView)
        
        let navView = UIView(frame: CGRect(x: 0, y: NAVBAR_HEIGHT-44, width: SCREEN_WIDTH, height: 44))
        navView.addSubview(searchBtn)
        navView.addSubview(categoryTitleView)
        self.gk_navigationBar.addSubview(navView)
        
        
        
//        view.addSubview(categoryTitleView)
        view.addSubview(listContainerView)
        categoryTitleView.listContainer = listContainerView
        requestMenuData();
        
    }
    override func viewDidLayoutSubviews() {
//        categoryTitleView.frame = CGRect(x: 0, y: NAVBAR_HEIGHT, width: SCREEN_WIDTH, height: CGFloat(MENU_HEIGHT))
        
        
        
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
        
        let selectIndex = _selectedIndex
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
            
            if dataAry.count < 10 {
                list?.isNoMoreData = true
            }else
            {
                list?.isNoMoreData = false
            }
            
            for dict in dataAry {
                if let model = JSONDeserializer<YDContentModel>.deserializeFrom(dict: dict as? [String:Any]) {
                    list?.dataMuAry.append(model)
                }
                
            }
            list?.reloadData()
        }
    }
    
    @objc func searchClick(_ button :UIButton){
        
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

extension InformationViewController : LoadDataDelegate{
    func loadPageIndex(_ pageIndex: NSInteger) {
        self.requestListPageIndex(pageIndex: pageIndex)
    }
}
extension InformationViewController : JXSegmentedViewDelegate
{
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        _selectedIndex = index
        self.listContainerView.didClickSelectedItem(at: index)
    }
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
        _selectedIndex = index
        self.listContainerView.didClickSelectedItem(at: index)
    }
}
extension InformationViewController : JXSegmentedListContainerViewDataSource
{
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedDataSource.dataSource.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        _selectedIndex = index
        let vc = InformationTableViewController()
        vc.delegate = self
        tempVc = vc
        vc.reqParam = YDReqModel();
        requestListPageIndex(pageIndex: 1)
        print("创建 /(index)")
        return vc
    }
    
    
}

