//
//  YDPosterCountModel.swift
//  TodayNews
//
//  Created by chao on 2020/12/24.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
//import SwiftyJSON

class YDPosterCountModel: YDBaseModel {

    var targetType : String = ""
    var targetId : String = ""
    var fansCount : Int = 0
    var follow : String = ""
    var followCount : Int = 0
    var like : Bool = false
    var likeCount : Int = 0
    var postCount : Int = 0
//    override init( jsonData : JSON) {
//        super.init(jsonData: jsonData)
//        targetType = jsonData["targetType"].stringValue
//        targetId = jsonData["targetId"].stringValue
//        fansCount = jsonData["fansCount"].intValue
//        follow = jsonData["follow"].stringValue
//        followCount = jsonData["followCount"].intValue
//        like = jsonData["like"].boolValue
//        likeCount = jsonData["likeCount"].intValue
//        postCount = jsonData["postCount"].intValue
//    }
}
