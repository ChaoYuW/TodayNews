//
//  YDChannelModel.swift
//  TodayNews
//
//  Created by chao on 2020/12/24.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
//import SwiftyJSON

class YDChannelModel: YDBaseModel {

    var actionUrl : String = ""
    var title : String = ""
    var subtitle : String = ""
    var contentType : String = ""
    var titleImage = YDImageModel()
    var count = YDPosterCountModel()
    var summary : String = ""
    var children : Array<YDChannelModel>?
    var displayStyle : String = ""

//    override init( jsonData : JSON) {
//        super.init(jsonData: jsonData)
//        actionUrl = jsonData["actionUrl"].stringValue
//        title = jsonData["title"].stringValue
//        subtitle = jsonData["subtitle"].stringValue
//        contentType = jsonData["contentType"].stringValue
//        titleImage = YDImageModel(jsonData: jsonData["titleImage"])
//        count = YDPosterCountModel(jsonData: jsonData["count"])
//        summary = jsonData["summary"].stringValue
//        children = jsonData["children"].arrayObject
//        displayStyle = jsonData["displayStyle"].stringValue
//
//    }
}
