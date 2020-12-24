//
//  YDResourceModel.swift
//  TodayNews
//
//  Created by chao on 2020/12/24.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
//import SwiftyJSON

class YDResourceModel: YDBaseModel {

    var contentType : String = ""
    var sourceUrl : String = ""
    var thumbUrl : String = ""
    var summary : String = ""
    
//    override init( jsonData : JSON) {
//        super.init(jsonData: jsonData)
//        contentType = jsonData["contentType"].stringValue
//        sourceUrl = jsonData["sourceUrl"].stringValue
//        thumbUrl = jsonData["thumbUrl"].stringValue
//        summary = jsonData["summary"].stringValue
//    }
}
