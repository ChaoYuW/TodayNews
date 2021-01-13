//
//  YDBottomView.swift
//  TodayNews
//
//  Created by chao on 2020/12/28.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
import SnapKit

class YDBottomView: UIView {

   lazy private var levelLab : UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 11.0)
        lab.textColor = UIColor.COLOR_RGBA(r: 235, g: 77, b: 72, alpha: 1)
        lab.numberOfLines = 1
        lab.adjustsFontSizeToFitWidth = true
//        lab.backgroundColor = UIColor.red
//        lab.textAlignment = .center
        lab.sizeToFit()
        return lab
    }()
    lazy private var timeLab : UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 12.0)
        lab.textColor = UIColor.COLOR_RGBA(r: 138, g: 138, b: 138, alpha: 1)
        lab.textAlignment = .left
        lab.numberOfLines = 1
//        lab.backgroundColor = UIColor.yellow
        lab.sizeToFit()
        return lab
    }()
    lazy private var infoLab : UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 12.0)
        lab.textColor = UIColor.COLOR_RGBA(r: 138, g: 138, b: 138, alpha: 1)
        lab.textAlignment = .left
//        lab.backgroundColor = UIColor.blue
//        lab.text = " 置顶 "
        return lab
    } ()
    
    private var tempModel : YDContentModel?
    var model : YDContentModel {
        set{
            tempModel = newValue
     
            timeLab.text = newValue.displayDate
            
            if newValue.count.readCount != -1 {
                infoLab.text = String(format: "%ld阅读", newValue.count.readCount);
            }else{
                infoLab.text = ""
            }
            // 置顶
            if newValue.topLevel > 1 {
                levelLab.text = " 置顶 "
                levelLab.alpha = 1
            }else
            {
                levelLab.text = ""
                levelLab.alpha = 0
//                levelLab.hidden = true
            }
            timeLab.sizeToFit()
            infoLab.sizeToFit()
        }
        get{
            return tempModel ?? YDContentModel()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupFrame()
        levelLab.text = " 置顶 "
        timeLab.text = "2020-07-21"
        infoLab.text = "10 阅读"
    }
    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        setupUI()
        setupFrame()
        levelLab.text = " 置顶 "
        timeLab.text = "2020-07-21"
        infoLab.text = "10 阅读"
    }
    
    override func layoutSubviews() {
        setupFrame()
    }
}


extension YDBottomView {
    func setupUI() {
        addSubview(levelLab)
        addSubview(timeLab)
        addSubview(infoLab)
        
    }
    func setupFrame() {

        let selfHeight = self.ec_height
        levelLab.sizeToFit()
        timeLab.sizeToFit()
        infoLab.sizeToFit()
        levelLab.frame = CGRect(x: adaptSize(20), y: (selfHeight - adaptSize(16))*0.5, width: levelLab.ec_width, height: adaptSize(16))
        levelLab.addCornerAndBorder(corners: .allCorners, radius: 3, borderWidth: 1, borderColor: UIColor.COLOR_RGBA(r: 235, g: 68, b: 68, alpha: 1))
        
        let lab_height = adaptSize(20)
        var offsetX : CGFloat = adaptSize(20)
        if tempModel?.topLevel ?? 0 > 1 {
            offsetX = levelLab.ec_right+CGFloat(10)
        }
        timeLab.frame = CGRect(x: offsetX, y: (selfHeight - lab_height)*0.5, width: timeLab.ec_width, height: lab_height)
        infoLab.frame = CGRect(x: timeLab.ec_right+10, y: timeLab.ec_top, width: infoLab.ec_width, height: lab_height)
        
//        levelLab.snp.makeConstraints { (make) in
//            make.left.equalTo(self).offset(adaptSize(20))
//            make.height.equalTo(adaptSize(20))
//            make.center.equalTo(self)
//        }
//        timeLab.snp.makeConstraints { (make) in
//
//            make.height.equalTo(adaptSize(20))
//            make.center.equalTo(self)
//            make.leading.equalTo(levelLab.snp.trailing)
//        }
//        infoLab.snp.makeConstraints { (make) in
//            make.left.equalTo(timeLab.snp.left).offset(adaptSize(10))
//            make.height.equalTo(adaptSize(20))
//            make.center.equalTo(self)
////            make.right.greaterThanOrEqualTo(adaptSize(20))
//        }
    }
    
}
