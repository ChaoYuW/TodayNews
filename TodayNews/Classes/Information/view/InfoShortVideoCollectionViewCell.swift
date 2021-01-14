//
//  InfoShortVideoCollectionViewCell.swift
//  TodayNews
//
//  Created by chao on 2021/1/14.
//  Copyright © 2021 chao. All rights reserved.
//

import UIKit

class InfoShortVideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var bottomBgView: UIView!
    
    @IBOutlet weak var titleLab: UILabel!
    
    
    private var tempModel : YDContentModel = YDContentModel ()

    var model : YDContentModel {
        set {
            tempModel = newValue
            
            titleLab.text = tempModel.title;
            if tempModel.displayResources.count > 0 {
                
                let imgModel = tempModel.displayResources.first
                
                imgView.kf.setImage(with: URL(string: imgModel?.thumbUrl ?? ""))
            }
        }
        get {
            return self.tempModel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        bottomBgView.backgroundColor = UIColor.COLOR_RGBA(r: 0, g: 0, b: 0, alpha: 0.1)
        titleLab.textColor = UIColor.white
    }

}
