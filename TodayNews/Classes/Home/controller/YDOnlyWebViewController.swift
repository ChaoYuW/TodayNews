//
//  YDOnlyWebViewController.swift
//  TodayNews
//
//  Created by chao on 2021/1/14.
//  Copyright © 2021 chao. All rights reserved.
//

import UIKit
import WebKit

class YDOnlyWebViewController: YDBaseViewController,WKUIDelegate,WKNavigationDelegate, UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFrame()
    }
    
    func setupUI() {
        self.view.addSubview(containerScrollView)
        containerScrollView.addSubview(myWebView)
        containerScrollView.addSubview(myTableView)
    }
    func setupFrame() {
        let mainHeight = SCREEN_HEIGHT - NAVBAR_HEIGHT
        containerScrollView.frame = CGRect(x: 0, y: NAVBAR_HEIGHT, width: SCREEN_WIDTH, height: mainHeight)
        myWebView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: mainHeight)
        myTableView.frame = CGRect(x: 0, y: myWebView.ec_bottom, width: SCREEN_WIDTH, height: mainHeight)
        containerScrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: mainHeight*2)
    }
    func addObservers() {
        myWebView.addObserver(self, forKeyPath: "scrollView.contentSize", options: .new, context: nil)
        myTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    func removeObservers() {
        myWebView.removeObserver(self, forKeyPath: "scrollView.contentSize")
        myTableView.removeObserver(self, forKeyPath: "contentSize")
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
    
    
    override class func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let scroll = object as? UIScrollView {
            if keyPath == "contentSize" {
                
            }
        } else if let webScroll = object as? WKWebView {
            if keyPath == "scrollView.contentSize" {
                
            }
        }
    }
    
    
   // #pragma mark - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if containerScrollView != scrollView{
            return
        }
        let offsetY = scrollView.contentOffset.y
        
        let webViewHeight = myWebView.ec_height
        let tableViewHeight = myTableView.ec_height
        
        var contentRect = containerScrollView.frame
        
        if offsetY <= 0 {
            contentRect.origin.y = 0
            
        }
        
        
        
        
    }
    //MARK:-WKNavigationDelegate
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //页面开始加载，可在这里给用户loading提示
    }
    
    
    //MARK:-lazy
    lazy var containerScrollView : UIScrollView = {
        
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.white
        return scrollView
        
    } ()
    lazy var myWebView: WKWebView = {
        let myWebView = ZXYWebViewPool.shared.getReusedWebView(forHolder: self)
        let web_url = URL.init(string: "http://106.14.148.72/dist/#/")
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
//    public func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
//            print("🚀开始加载图片\(urlSchemeTask.request.url)", Date.init().timeIntervalSince1970)
//            
//            if let url = urlSchemeTask.request.url {
//                var components = URLComponents.init(string: url.absoluteString)
//                components?.scheme = "https"
//                if let url = components?.url {
//                    KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil) { (image, _, _, _) in
//                        var data: Data? = nil
//                        if let image = image?.kf.gifRepresentation() {
//                            data = image
//                        }else if let image = image?.kf.pngRepresentation() {
//                            data = image
//                        }else if let image = image?.kf.jpegRepresentation(compressionQuality: 1) {
//                            data = image
//                        }
//                        print("🚀结束加载图片\(urlSchemeTask.request.url)", Date.init().timeIntervalSince1970)
//                        if let data = data {
//                            let response = URLResponse.init(url: url, mimeType: nil, expectedContentLength: data.count, textEncodingName: nil)
//                            urlSchemeTask.didReceive(response)
//                            urlSchemeTask.didReceive(data)
//                            urlSchemeTask.didFinish()
//                        }else {
//                            urlSchemeTask.didFailWithError(NSError.init(domain: "10086", code: 10086, userInfo: nil))
//                        }
//                    }
//                    return
//                }
//            }
//            urlSchemeTask.didFailWithError(NSError.init(domain: "10086", code: 10086, userInfo: nil))
//        }


}
