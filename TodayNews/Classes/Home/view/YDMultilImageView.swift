//
//  YDMultilImageView.swift
//  TodayNews
//
//  Created by chao on 2021/1/12.
//  Copyright © 2021 chao. All rights reserved.
//

import UIKit
import Kingfisher

class YDMultilImageView: UIView {

    let TAG = 1000
    let itemNum = 8
    var selfWidth : CGFloat = 0
    var spaceRow : CGFloat = 0
    var spaceCol : CGFloat = 0
    
    var imgViewMuAry : [UIImageView] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        
        imgViewMuAry.removeAll()
        for i in 0 ..< itemNum{
            let imgView = UIImageView()
            imgView.tag = TAG + i
            imgViewMuAry.append(imgView)
//            imgView.backgroundColor = UIColor.orange
            self.addSubview(imgView)
        }
        
        selfWidth = SCREEN_WIDTH - 2*adaptSize(20)
        spaceRow = adaptSize(5)
        spaceCol = adaptSize(5)
    }
    public func setResource(resources:NSArray)
    {
        let count = resources.count
        
        for i in 0 ..< itemNum{
            if let imgView = viewWithTag(TAG+i) {
                imgView.frame = CGRect.zero
                imgView.alpha = 0
            }
        }
        
        if count == 0 {
            self.ec_size = CGSize(width: 0, height: 0)
            return
        }
        if count == 1 {
            let imgView = viewWithTag(TAG) as! UIImageView
            imgView.alpha = 1
            let singleSize = CGSize(width: selfWidth, height: selfWidth/1.96)
            imgView.frame = CGRect(x: 0, y: 0, width: singleSize.width, height: singleSize.height)
            let resouceModel = resources.firstObject as! YDResourceModel
            imgView.kf.setImage(with: URL(string: resouceModel.thumbUrl))
            self.ec_size = CGSize(width: selfWidth, height: singleSize.height)
            
            return
        }
        
        var c_width = (selfWidth - 2*spaceCol)/3
        if count == 2 || count == 4 {
            c_width = (selfWidth - 2*spaceCol)/2
        }
        let c_height = c_width/1.34
        
        var bottom : CGFloat = 0
        for i in 0 ..< itemNum{
            
            var rowNum = i/3
            var colNum = i%3
            if count == 4 || count == 2 {
                rowNum = i/2
                colNum = i%2
            }
            let x = CGFloat(colNum) * (c_width + spaceCol)
            let y = CGFloat(rowNum) * (c_height + spaceRow)
            
            let imgView = viewWithTag(TAG+i) as! UIImageView
            if i < count {
                imgView.alpha = 1
                let resouceModel = resources[i] as! YDResourceModel
                imgView.frame = CGRect(x: x, y: y, width: c_width, height: c_height)
                imgView.kf.setImage(with: URL(string: resouceModel.thumbUrl))
            }else
            {
                imgView.frame = CGRect.zero
            }
            
            if i == count-1 {
                bottom = imgView.ec_bottom
            }
        }
        self.ec_size = CGSize(width: selfWidth, height: bottom)
        
    }
    
}
