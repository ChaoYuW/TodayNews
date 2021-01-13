//
//  YDLargerImageTableViewCell.swift
//  TodayNews
//
//  Created by chao on 2020/12/29.
//  Copyright © 2020 chao. All rights reserved.
//

import UIKit


class YDMultiImageTableViewCell: UITableViewCell {
    
    
    var titleLab : UILabel!
    var multiImageView : YDMultilImageView!
    
    var bottomView : YDBottomView!
    var separatorLine  : UIView!
    
    
    private var tempModel : YDContentModel = YDContentModel ()

    var model : YDContentModel {
        set {
            tempModel = newValue
            
            titleLab.text = newValue.title
            multiImageView.setResource(resources: newValue.displayResources as NSArray)
            bottomView.model = newValue
            
            let offset_x = adaptSize(20)
            let selfWidth = SCREEN_WIDTH-2*offset_x
            let size = titleLab.sizeThatFits(CGSize(width: selfWidth,height: 200))
            
            titleLab.ec_size = size

            multiImageView.ec_origin = CGPoint(x: offset_x, y: titleLab.ec_bottom + adaptSize(16))
            bottomView.ec_origin = CGPoint(x: 0, y: multiImageView.ec_bottom)
            separatorLine.ec_origin = CGPoint(x: offset_x, y: bottomView.ec_bottom-1)
            model.cellHeight = bottomView.ec_bottom
        }
        get {
            return self.tempModel
        }
    }
    
    
    class func cellWithTableView(tableView : UITableView) -> YDMultiImageTableViewCell {
        let cellID = "YDMultiImageTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = YDMultiImageTableViewCell(style: .default, reuseIdentifier: cellID)
        }
        return cell! as! YDMultiImageTableViewCell
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
        let offset_y = adaptSize(18)
        let selfWidth = SCREEN_WIDTH-2*offset_x
        titleLab = UILabel(frame: CGRect(x: offset_x, y: offset_y, width: selfWidth, height: 0))
        titleLab?.numberOfLines = 0
        
        multiImageView = YDMultilImageView()
        multiImageView?.frame = CGRect(x: 0, y: titleLab!.ec_bottom, width: selfWidth, height: 0)
        bottomView = YDBottomView()
        bottomView?.frame = CGRect(x: 0, y: multiImageView!.ec_bottom, width: selfWidth, height: adaptSize(44))
        
        separatorLine = UIView()
        separatorLine.backgroundColor = COLOR_RGBA(r: 238, g: 238, b: 238, alpha: 1)
        separatorLine.frame = CGRect(x: offset_x, y: bottomView!.ec_bottom, width: selfWidth, height:1/UIScreen.main.scale)
        separatorLine.frame = CGRect(x: offset_x, y: bottomView!.ec_bottom, width: selfWidth, height:1)
        
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(multiImageView)
        self.contentView.addSubview(bottomView)
        self.contentView.addSubview(separatorLine)
        
    }
    
}
