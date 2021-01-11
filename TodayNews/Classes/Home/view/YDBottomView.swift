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
        lab.font = UIFont.systemFont(ofSize: 12.0)
        lab.textColor = UIColor.COLOR_RGBA(r: 138, g: 138, b: 138, alpha: 1)
        return lab
    }()
    lazy private var timeLab : UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 12.0)
        lab.textColor = UIColor.COLOR_RGBA(r: 138, g: 138, b: 138, alpha: 1)
        lab.textAlignment = .left
        return lab
    }()
    lazy private var infoLab : UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 12.0)
        lab.textColor = UIColor.COLOR_RGBA(r: 138, g: 138, b: 138, alpha: 1)
        lab.textAlignment = .left
//        lab.text = " 置顶 "
        return lab
    } ()
    var model : YDContentModel {
        set{
            
        }
        get{
            return self.model
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupFrame()
        levelLab.text = "置顶"
        timeLab.text = "2020-07-21"
        infoLab.text = "10 阅读"
    }
    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        setupUI()
        setupFrame()
        levelLab.text = "置顶"
        timeLab.text = "2020-07-21"
        infoLab.text = "10 阅读"
    }
    
}


extension YDBottomView {
    func setupUI() {
        addSubview(levelLab)
        addSubview(timeLab)
        addSubview(infoLab)
        
    }
    func setupFrame() {
        levelLab.snp.makeConstraints { (make) in
            make.left.equalTo(adaptSize(20))
            make.height.equalTo(adaptSize(20))
            make.width.equalTo(40)
            make.center.equalTo(self)
        }
        timeLab.snp.makeConstraints { (make) in
            make.left.equalTo(levelLab.snp.right)
            make.height.equalTo(adaptSize(20))
            make.center.equalTo(self)
        }
        infoLab.snp.makeConstraints { (make) in
            make.left.equalTo(timeLab.snp.right)
            make.height.equalTo(adaptSize(20))
            make.center.equalTo(self)
            make.right.greaterThanOrEqualTo(adaptSize(20))
        }
    }
    
}
