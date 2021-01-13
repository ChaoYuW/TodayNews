//
//  YDContentModel.swift
//  TodayNews
//
//  Created by chao on 2020/12/24.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit

class YDContentModel: YDBaseModel {

    var channel = YDChannelModel()
    var actionUrl : String = ""
    var albumTotalCount : String = ""
    var title : String = ""
    var subtitle : String = ""
    var author : String = ""
    var summary : String = ""
    var origin : String = ""
    var originUrl : String = ""
    var contentType : String = ""
    var displayStyle : String = ""
    var displayDate : String = ""
    var topLevel : Int = 0
    var liveStatus : String = ""
    var count = YDCountModel()
    var displayResources : [YDMultipleModel] = [YDMultipleModel] ()
    
    
    
    var followCount : Float = 0.0
    
    var cellHeight : CGFloat = 0

    
    
    
    
}
