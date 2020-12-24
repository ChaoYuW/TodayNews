//
//  YDBaseModel.swift
//  TodayNews
//
//  Created by chao on 2020/12/24.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
import HandyJSON

class YDBaseModel: HandyJSON {

    var id : String = ""
    var shareUrl : String = ""
    required init() {
        
    }
//    init( jsonData : JSON) {
//        id = jsonData["id"].stringValue
//        shareUrl = jsonData["shareUrl"].stringValue
//    }
}
