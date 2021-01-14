//
//  LoadMoreDataProtocol.swift
//  TodayNews
//
//  Created by chao on 2021/1/14.
//  Copyright © 2021 chao. All rights reserved.
//

import Foundation


protocol LoadDataDelegate : NSObjectProtocol{
    
    func loadPageIndex(_ pageIndex : NSInteger)
}
