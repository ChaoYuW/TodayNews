//
//  YDWebViewController.swift
//  TodayNews
//
//  Created by chao on 2021/1/14.
//  Copyright © 2021 chao. All rights reserved.
//

import UIKit
import WebKit

class YDWebViewController: YDBaseViewController,WKUIDelegate,WKNavigationDelegate, UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFrame()
    }
    

    
    
    
    func setupUI() {
        self.view.addSubview(mainScrollView)
        mainScrollView.addSubview(myWebView)
        mainScrollView.addSubview(myTableView)
    }
    func setupFrame() {
        let mainHeight = SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT
        mainScrollView.frame = CGRect(x: 0, y: NAVBAR_HEIGHT, width: SCREEN_WIDTH, height: mainHeight)
        myWebView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: mainHeight)
        myTableView.frame = CGRect(x: 0, y: myWebView.ec_bottom, width: SCREEN_WIDTH, height: mainHeight)
        mainScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: mainHeight*2)
    }
    
    // #pragma mark - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    // #pragma mark - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
   // #pragma mark - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    //MARK:-WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //页面开始加载，可在这里给用户loading提示
    }
    
    
    //MARK:-lazy
    lazy var mainScrollView : UIScrollView = {
        
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.delegate = self
        return scrollView
        
    } ()
    lazy var myWebView: WKWebView = {
        let myWebView = WKWebView.init(frame: self.view.frame)
        let web_url = URL.init(string: "http://www.baidu.com")
        myWebView.load(URLRequest.init(url: web_url!))
        myWebView.navigationDelegate = self
        myWebView.uiDelegate = self
        return myWebView
    }()
    lazy var webConfiguration: WKWebViewConfiguration = {
        let configuration = WKWebViewConfiguration.init()
        let preferences = WKPreferences.init()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        configuration.preferences = preferences
//        configuration.userContentController = self.webUserContentController
        return configuration
    }()
    lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    

}
