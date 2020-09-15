//
//  HomeViewController.swift
//  TodayNews
//
//  Created by chao on 2020/9/10.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
import JXSegmentedView

class HomeViewController: UIViewController {

    private var segmentedDataSource: JXSegmentedTitleDataSource!
    
    
    lazy private var categoryTitleView: JXSegmentedView = {
        let segmentView = JXSegmentedView()
        segmentView.backgroundColor = UIColor.white
        //2、配置数据源
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.titles = getRandomTitles()
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentView.dataSource = segmentedDataSource
        
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
        
    }
    override func viewDidLayoutSubviews() {
        categoryTitleView.frame = CGRect(x: 0, y: W_NAVBARHEIGHT, width: SCREEN_WIDTH, height: CGFloat(CATEGORY_HEIGHT))
        
        listContainerView.frame = CGRect(x: 0, y:categoryTitleView.frame.maxY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-categoryTitleView.frame.maxY-W_TABBARHEIGHT)
        
    }
    
    func getRandomTitles() -> [String] {
        let titles = ["猴哥", "青蛙王子", "旺财", "粉红猪", "喜羊羊", "黄焖鸡", "小马哥", "牛魔王", "大象先生", "神龙"]
        let randomCount = Int(arc4random()%7 + 4)
        var tempTitles = titles
        var resultTitles = [String]()
        for _ in 0..<randomCount {
            let randomIndex = Int(arc4random()%UInt32(tempTitles.count))
            resultTitles.append(tempTitles[randomIndex])
            tempTitles.remove(at: randomIndex)
        }
        return resultTitles;
    }

}

extension HomeViewController : JXSegmentedListContainerViewDataSource
{
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedDataSource.dataSource.count
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        let vc = InformationTableViewController()
        vc.tableView.backgroundColor = main_bg_color
        return vc
    }
    
    
}

