//
//  YDReqModel.swift
//  TodayNews
//
//  Created by chao on 2020/12/25.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit

class YDReqModel: NSObject {

    var pageIndex : Int = 1
    var pageSize : Int = 10
    var orderBy : String = "create_desc"
    var channel = [String : String]()
    
}
