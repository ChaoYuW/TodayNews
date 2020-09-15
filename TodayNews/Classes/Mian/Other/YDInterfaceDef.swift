//
//  YDInterfaceDef.swift
//  TodayNews
//
//  Created by chao on 2020/9/10.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit

    
    struct API {
      //任何地方调用 API.hostName + '具体地址'，
        static let BASE_URL = "https://hard.shmedia.tech"
       //这里可以写其他的，用于测试
        static let BASE_URLTest = "https://hard.shmedia.tech"

    }
    
    //2 系统 系统相关接口
    //获取广告信息
    let sys_billboardURL = "/media-basic-port/api/app/sys/billboard/list"
    //获取升级信息
    let sys_versionURL = "/media-basic-port/api/app/sys/version"
    //获取字典
    let sys_dictListURL = "/media-basic-port/api/app/sys/dict/list"
    
    // 资讯栏目
    let news_channel_listUrl = "/media-basic-port/api/app/news/channel/list"
    //获取"资讯"稿件列表 获取专题稿件列表
    let news_content_listURL = "/media-basic-port/api/app/news/content/list"
