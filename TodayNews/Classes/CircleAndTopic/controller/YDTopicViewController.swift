//
//  YDTopicViewController.swift
//  TodayNews
//
//  Created by chao on 2021/1/25.
//  Copyright © 2021 chao. All rights reserved.
//

import UIKit
import Kingfisher

class YDTopicViewController: YDBaseViewController {

    
    //懒加载
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableView.frame = CGRect(x: 0, y: NAVBAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-NAVBAR_HEIGHT)
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
        //        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.allowsSelection = false
        tableView.register(YDMomentTableViewCell.self, forCellReuseIdentifier: "cellId")
        return tableView
    }()
    //中介 负责处理数据和事件
    lazy var presenter : MomentPresenter = {
        let presenter = MomentPresenter()
        return presenter
    }()
    var dataMuAry = NSMutableArray()
    var layoutMuAry = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        // Do any additional setup after loading the view.
        //中间者 处理数据和事件
        self.presenter.getData { (dataArray, layoutArray) in
            //            print("刷新")
            self.dataMuAry = dataArray
            self.layoutMuAry = layoutArray
            self.tableView.reloadData()
        }
        //限制内存高速缓存大小为50MB
        ImageCache.default.memoryStorage.config.totalCostLimit = 50 * 1024 * 1024
        //限制内存缓存最多可容纳150张图像
        ImageCache.default.memoryStorage.config.countLimit = 150
        self.presenter.fullTextBlock = { (indexPath) in
            self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        }
        
    }

    func setupUI() {
        self.view.addSubview(self.tableView)
    }
    // MARK: Events
    @objc func clearCache() {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache {
            print("图片清除缓存完毕")
        }
    }

}
// MARK: UITableViewDelegate, UITableViewDataSource
extension YDTopicViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataMuAry.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > self.layoutMuAry.count - 1 { return 0 }
        let layout : ECLayout = self.layoutMuAry[indexPath.row] as! ECLayout
        return layout.cellHeight
    }
    func tableView(_ tableVdiew: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YDMomentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! YDMomentTableViewCell
        let model:ECModel = self.dataMuAry[indexPath.row] as! ECModel
        var layout:ECLayout?
        if indexPath.row <= self.layoutMuAry.count - 1 {
            layout = self.layoutMuAry[indexPath.row] as? ECLayout
        }
        cell.delegate = self.presenter 
        cell.cellIndexPath = indexPath
        cell.configureCell(model: model, layout: layout)
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
