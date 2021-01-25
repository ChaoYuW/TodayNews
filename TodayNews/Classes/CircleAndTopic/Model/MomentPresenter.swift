//
//  MomentPresenter.swift
//  TodayNews
//
//  Created by chao on 2021/1/25.
//  Copyright © 2021 chao. All rights reserved.
//

import UIKit
import HandyJSON

// 数据模型
struct ECModel : HandyJSON {
    var headPic: String = ""
    var nickName: String?
    var time: String?
    var source: String?
    var title: String?
    var images: [String] = []
}
// 布局信息
struct ECLayout : HandyJSON {
    var attributedString: NSMutableAttributedString?
    var cellHeight: CGFloat = 0
    var expan: Bool = false //是否展开
}
//正则匹配规则
let KRegularMatcheHttpUrl = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" // 图标+描述 替换HTTP链接
let KRegularMatcheTopic = "#[^#]+#"    // 话题匹配 #话题#
let KRegularMatcheUser = "@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*"  // @用户匹配
let KRegularMatcheEmotion = "\\[[^ \\[\\]]+?\\]"   //表情匹配 [爱心]
let KTitleLengthMax = 99  // 默认标题最多字符个数，但不固定，取决于高亮的字符是否会被截断

//数据请求完毕的回调Block
typealias ECDataCompleteBlock = (_ dataArray: NSMutableArray, _ layoutArray: NSMutableArray) ->Void
//标题全文点击回调
typealias ECFullTextCompleteBlock = (_ indexPath: IndexPath) ->Void

class MomentPresenter: NSObject {

    var dataArray = NSMutableArray()
    var layoutArray = NSMutableArray()
    
    var fullTextBlock: ECFullTextCompleteBlock?
    
    func getData(completeBlock: @escaping ECDataCompleteBlock) {
        DispatchQueue.global(qos: .default).async {
            let path:String? = Bundle.main.path(forResource: "Data", ofType: "plist")
            let array: [Dictionary] = NSArray(contentsOfFile: path!) as! [Dictionary<String, Any>]
            for dict in array {
                var model = ECModel()
                if let object = ECModel.deserialize(from: dict) {
                    model = object
                }
                self.dataArray.add(model)
                //元组
                let attStrAndHeight:(attributedString:NSMutableAttributedString, height:CGFloat) = self.matchesResultOfTitle(title: model.title!, expan: false)
                let layout:ECLayout = ECLayout(attributedString: attStrAndHeight.attributedString, cellHeight: (15 + 35 + 15 + attStrAndHeight.height + 15 + self.heightOfImages(images: model.images)), expan: false)
                self.layoutArray.add(layout)
            }
            //操作完成，调用主线程来刷新界面
            DispatchQueue.main.async {
                completeBlock(self.dataArray,self.layoutArray)
            }
        }
    }
    
    
    //标题正则匹配结果
    func matchesResultOfTitle(title: String, expan: Bool) -> (attributedString : NSMutableAttributedString , height : CGFloat) {
        //原富文本标题
        var attributedString:NSMutableAttributedString = NSMutableAttributedString(string:title)
        //原富文本的范围
        let titleRange = NSRange(location: 0, length:attributedString.length)
        
        //最大字符 截取位置
        var cutoffLocation = KTitleLengthMax
        //        print("\(attributedString.length)")
        
        //图标+描述 替换HTTP链接
        let urlRanges:[NSRange] = getRangesFromResult(regexStr:KRegularMatcheHttpUrl, title: title)
        for range in urlRanges {
            let attchimage:NSTextAttachment = NSTextAttachment()
            attchimage.image = UIImage.init(named: "photo")
            attchimage.bounds = CGRect.init(x: 0, y: -2, width: 16, height: 16)
            let replaceStr : NSMutableAttributedString = NSMutableAttributedString(attachment: attchimage)
            replaceStr.append(NSAttributedString.init(string: "查看图片")) //添加描述
            replaceStr.addAttributes([NSAttributedString.Key.link :"http://img.wxcha.com/file/201811/21/afe8559b5e.gif"], range: NSRange(location: 0, length:replaceStr.length ))
            //注意：涉及到文本替换的 ，每替换一次，原有的富文本位置发生改变，下一轮替换的起点需要重新计算！
            let newLocation = range.location - (titleRange.length - attributedString.length)
            //图标+描述 替换HTTP链接字符
            attributedString.replaceCharacters(in: NSRange(location: newLocation, length: range.length), with: replaceStr)
            //如果最多字符个数会截断高亮字符，则舍去高亮字符
            if cutoffLocation >= newLocation && cutoffLocation <= newLocation + range.length {
                cutoffLocation = newLocation
            }
            //             print("==== \(attributedString.length)")
        }
        
        //话题匹配
        let topicRanges:[NSRange] = getRangesFromResult(regexStr: KRegularMatcheTopic, title: attributedString.string)
        for range in topicRanges {
            attributedString.addAttributes([NSAttributedString.Key.link :"https://github.com/ChaoYuW/TodayNews"], range: range)
            //如果最多字符个数会截断高亮字符，则舍去高亮字符
            if cutoffLocation >= range.location && cutoffLocation <= range.location + range.length {
                cutoffLocation = range.location
            }
        }
        
        //@用户匹配
        let userRanges:[NSRange] = getRangesFromResult(regexStr: KRegularMatcheUser,title: attributedString.string)
        for range in userRanges {
            attributedString.addAttributes([NSAttributedString.Key.link :"https://mp.csdn.net/console/article?spm=1010.2135.3001.5448"], range: range)
            //如果最多字符个数会截断高亮字符，则舍去高亮字符
            if cutoffLocation >= range.location && cutoffLocation <= range.location + range.length {
                cutoffLocation = range.location
            }
        }
        
        //表情匹配
        let emotionRanges:[NSRange] = getRangesFromResult(regexStr: KRegularMatcheEmotion,title: attributedString.string)
        //经过上述的匹配替换后，此时富文本的范围
        let currentTitleRange = NSRange(location: 0, length:attributedString.length)
        for range in emotionRanges {
            //表情附件
            let attchimage:NSTextAttachment = NSTextAttachment()
            attchimage.image = UIImage.init(named: "爱你")
            attchimage.bounds = CGRect.init(x: 0, y: -2, width: 16, height: 16)
            let stringImage : NSAttributedString = NSAttributedString(attachment: attchimage)
            //注意：每替换一次，原有的位置发生改变，下一轮替换的起点需要重新计算！
            let newLocation = range.location - (currentTitleRange.length - attributedString.length)
            //图片替换表情文字
            attributedString.replaceCharacters(in: NSRange(location: newLocation, length: range.length), with: stringImage)
            //如果最多字符个数会截断高亮字符，则舍去高亮字符
            //字符替换之后，截取位置也要更新
            cutoffLocation -= (currentTitleRange.length - attributedString.length)
            if cutoffLocation >= newLocation && cutoffLocation <= newLocation + range.length {
                cutoffLocation = newLocation
            }
        }
        
        //超出字符个数限制，显示全文
        if attributedString.length > cutoffLocation {
            var fullText: NSMutableAttributedString
            if expan {
                attributedString.append(NSAttributedString(string:"\n"))
                fullText = NSMutableAttributedString(string:"收起")
                fullText.addAttributes([NSAttributedString.Key.link :"FullText"], range: NSRange(location:0, length:fullText.length ))
            }else {
                attributedString = attributedString.attributedSubstring(from: NSRange(location: 0, length: cutoffLocation)) as! NSMutableAttributedString
                fullText = NSMutableAttributedString(string:"...全文")
                fullText.addAttributes([NSAttributedString.Key.link :"FullText"], range: NSRange(location:3, length:fullText.length - 3))
            }
            attributedString.append(fullText)
        }
        //段落
        let paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4 //行间距
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle :paragraphStyle, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], range: NSRange(location:0, length:attributedString.length))
        
        //元组
        let attributedStringHeight = (attributedString, heightOfAttributedString(attributedString))
        return attributedStringHeight
    }
    //根据匹配规则返回所有的匹配结果
    fileprivate func getRangesFromResult(regexStr : String, title: String) -> [NSRange] {
        // 0.匹配规则
        let regex = try? NSRegularExpression(pattern:regexStr, options: [])
        // 1.匹配结果
        let results = regex?.matches(in:title, options:[], range: NSRange(location: 0, length: NSAttributedString(string: title).length))
        // 2.遍历结果 数组
        var ranges = [NSRange]()
        for res in results! {
            ranges.append(res.range)
        }
        return ranges
    }
    //计算富文本的高度
    func heightOfAttributedString(_ attributedString: NSAttributedString) -> CGFloat {
        let height : CGFloat =  attributedString.boundingRect(with: CGSize(width: UIScreen.main.bounds.size.width - 15 * 2, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).height
        return ceil(height)
    }
    
    //图组的高度
    func heightOfImages(images:[String]) -> CGFloat {
        if images.count == 0 {
            return 0
        } else {
            let picHeight = (UIScreen.main.bounds.size.width - 15 * 2 - 5 * 2)/3
            var height = 0
            if images.count < 5 {
                height = ((images.count - 1)/2 + 1) * Int(picHeight) + (images.count - 1)/2 * 5 + 15
            }else {
                height = ((images.count - 1)/3 + 1) * Int(picHeight) + (images.count - 1)/3 * 5 + 15
            }
            return CGFloat(height);
        }
    }
    
}

