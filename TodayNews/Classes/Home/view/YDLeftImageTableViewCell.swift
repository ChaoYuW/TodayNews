//
//  YDLeftImageTableViewCell.swift
//  TodayNews
//
//  Created by chao on 2020/12/25.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit
import Kingfisher

class YDLeftImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var bottomView: YDBottomView!
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
    
    
    
    
    @IBOutlet weak var separatorLine: UIView!
    class func cellWithTableView(tableView : UITableView) -> YDLeftImageTableViewCell {
        let cellID = "YDLeftImageTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = Bundle.main.loadNibNamed("YDLeftImageTableViewCell", owner: nil, options: nil)?.last as! YDLeftImageTableViewCell
        }
        return cell! as! YDLeftImageTableViewCell
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        titleLab.text = ""
        imgView.layer.cornerRadius = 5
        imgView.layer.masksToBounds = true
        //分割线颜色
        separatorLine.backgroundColor = COLOR_RGBA(r: 238, g: 238, b: 238, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
