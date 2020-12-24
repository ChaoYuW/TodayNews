//
//  YDCountModel.swift
//  TodayNews
//
//  Created by chao on 2020/12/24.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
import HandyJSON

class YDCountModel: HandyJSON {
    

    var fansCount : Int = 0
    
    var follow : Bool = false
    var followCount : Int = 0
    
    var like : Bool = false
    var likeCount : Int = 0
    
    var read : Bool = false
    var readCount : Int = 0
    
    var comment : Bool = false
    var commentCount : Int = 0
    
    var favorite : Bool = false
    
    
    var targetId : String = ""
    var targetType : String = ""

    
    required init() {
        
    }

}
