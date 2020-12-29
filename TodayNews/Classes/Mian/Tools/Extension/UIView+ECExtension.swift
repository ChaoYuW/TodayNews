//
//  UIView+ECExtension.swift
//  TodayNews
//
//  Created by chao on 2020/12/29.
//  Copyright © 2020 chao. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func addCorner(corners: UIRectCorner , radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    //给继承于view的类添加阴影
    ///   - Parameters:
    ///   - shadowColor: 阴影的颜色
    ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移]);
    ///   - shadowOpacity: 阴影的透明度
    ///   - shadowRadius: 阴影半径，默认 3
    func addShadow(shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
            // 设置阴影颜色
            layer.shadowColor = shadowColor.cgColor
            // 设置透明度
            layer.shadowOpacity = shadowOpacity
            // 设置阴影半径
            layer.shadowRadius = shadowRadius
            // 设置阴影偏移量
            layer.shadowOffset = shadowOffset
        }
    // MARK: 5.3、添加阴影和圆角并存
        /// 添加阴影和圆角并存
        /// - Parameters:
        ///   - conrners: 具体哪个圆角
        ///   - radius: 圆角大小
        ///   - shadowColor: 阴影的颜色
        ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移]);
        ///   - shadowOpacity: 阴影的透明度
        ///   - shadowRadius: 阴影半径，默认 3
        func addCornerAndShadow(superview: UIView, conrners: UIRectCorner , radius: CGFloat = 3, shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
        
            let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
        
            let subLayer = CALayer()
            let fixframe = self.frame
            subLayer.frame = fixframe
            subLayer.cornerRadius = shadowRadius
            subLayer.backgroundColor = shadowColor.cgColor
            subLayer.masksToBounds = false
            // shadowColor阴影颜色
            subLayer.shadowColor = shadowColor.cgColor
            // shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
            subLayer.shadowOffset = shadowOffset
            // 阴影透明度，默认0
            subLayer.shadowOpacity = shadowOpacity
            // 阴影半径，默认3
            subLayer.shadowRadius = shadowRadius
            superview.layer.insertSublayer(subLayer, below: self.layer)
        }

        // MARK: 5.4、添加边框
        /// 添加边框
        /// - Parameters:
        ///   - width: 边框宽度
        ///   - color: 边框颜色
        func addBorder(borderWidth: CGFloat, borderColor: UIColor) {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.cgColor
            layer.masksToBounds = true
        }

        // MARK: 5.5、添加顶部的 边框
        /// 添加顶部的 边框
        /// - Parameters:
        ///   - borderWidth: 边框宽度
        ///   - borderColor: 边框颜色
        func addBorderTop(borderWidth: CGFloat, borderColor: UIColor) {
            addBorderUtility(x: 0, y: 0, width: frame.width, height: borderWidth, color: borderColor)
        }

        // MARK: 5.6、添加顶部的 内边框
        /// 添加顶部的 内边框
        /// - Parameters:
        ///   - borderWidth: 边框宽度
        ///   - borderColor: 边框颜色
        ///   - padding: 边框距离边上的距离
        func addBorderTopWithPadding(borderWidth: CGFloat, borderColor: UIColor, padding: CGFloat) {
            addBorderUtility(x: padding, y: 0, width: frame.width - padding*2, height: borderWidth, color: borderColor)
        }

        // MARK: 5.7、添加底部的 边框
        /// 添加底部的 边框
        /// - Parameters:
        ///   - borderWidth: 边框宽度
        ///   - borderColor: 边框颜色
        func addBorderBottom(borderWidth: CGFloat, borderColor: UIColor) {
            addBorderUtility(x: 0, y: frame.height - borderWidth, width: frame.width, height: borderWidth, color: borderColor)
        }

        // MARK: 5.8、添加左边的 边框
        /// 添加左边的 边框
        /// - Parameters:
        ///   - borderWidth: 边框宽度
        ///   - borderColor: 边框颜色
        func addBorderLeft(borderWidth: CGFloat, borderColor: UIColor) {
            addBorderUtility(x: 0, y: 0, width: borderWidth, height: frame.height, color: borderColor)
        }

        // MARK: 5.9、添加右边的 边框
        /// 添加右边的 边框
        /// - Parameters:
        ///   - borderWidth: 边框宽度
        ///   - borderColor: 边框颜色
        func addBorderRight(borderWidth: CGFloat, borderColor: UIColor) {
            addBorderUtility(x: frame.width - borderWidth, y: 0, width: borderWidth, height: frame.height, color: borderColor)
        }

        // MARK:- 5.10、画圆环
        /// 画圆环
        /// - Parameters:
        ///   - fillColor: 内环的颜色
        ///   - strokeColor: 外环的颜色
        ///   - strokeWidth: 外环的宽度
        func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
            let ciecleRadius = self.ec_width > self.ec_height ? self.ec_height : self.ec_width
            let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: ciecleRadius, height: ciecleRadius), cornerRadius: ciecleRadius / 2)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = fillColor.cgColor
            shapeLayer.strokeColor = strokeColor.cgColor
            shapeLayer.lineWidth = strokeWidth
            self.layer.addSublayer(shapeLayer)
        }
    
    /// 边框的私有内容
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
}
