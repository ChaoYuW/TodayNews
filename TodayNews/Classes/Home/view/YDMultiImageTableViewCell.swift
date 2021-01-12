//
//  YDLargerImageTableViewCell.swift
//  TodayNews
//
//  Created by chao on 2020/12/29.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit


class YDMultiImageTableViewCell: UITableViewCell {
    
    
    var titleLab : UILabel?
    var multiImageView : YDMultilImageView?
    
    var bottomView : YDBottomView?
    
    private var tempModel : YDContentModel = YDContentModel ()

    var model : YDContentModel {
        set {
            tempModel = newValue
            multiImageView?.setResource(resources: newValue.displayResources as NSArray)
        }
        get {
            return self.tempModel
        }
    }
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createCellUI() {
        
        let offset_x = adaptSize(20)
        let offset_y = adaptSize(10)
        titleLab = UILabel(frame: CGRect(x: offset_x, y: offset_y, width: SCREEN_WIDTH-2*offset_x, height: 0))
        
        multiImageView = YDMultilImageView()
        bottomView = YDBottomView()
        self.contentView.addSubview(titleLab!)
        self.contentView.addSubview(multiImageView!)
        self.contentView.addSubview(bottomView!)
        
    }
    
}
