//
//  UIImageWaterMark+Extension.swift
//  WatermarkDemo
//
//  Created by 也许、 on 2017/10/9.
//  Copyright © 2017年 也许、. All rights reserved.
//

import UIKit

extension UIImage {
    
    //水印位置枚举
    enum WaterMarkCorner{
        case TopLeft
        case TopRight
        case BottomLeft
        case BottomRight
    }
    
    
    /// 添加文字水印
    ///
    /// - Parameters:
    ///   - waterMarkText: 文字
    ///   - corner: 位置
    ///   - margin: 间距
    ///   - waterMarkTextColor: 文字颜色
    ///   - waterMarkTextFont: 文字大小
    ///   - backgroundColor: 背景色
    func createTextWaterMark(waterMarkText:String, corner:WaterMarkCorner = .BottomRight,
                          margin:CGPoint = CGPoint(x: 20, y: 20),
                          waterMarkTextColor:UIColor = UIColor.black,
                          waterMarkTextFont:UIFont = UIFont.systemFont(ofSize: 60),
                          backgroundColor:UIColor = UIColor.clear) -> UIImage{
        
        // 文字属性
        let textAttributes = [NSAttributedStringKey.foregroundColor:waterMarkTextColor,
                              NSAttributedStringKey.font:waterMarkTextFont,
                              NSAttributedStringKey.backgroundColor:backgroundColor]
        
        // 根据数据获取文字的大小
        let textSize = NSString(string: waterMarkText).size(withAttributes: textAttributes)
        let imageSize = self.size
        
        // 生成水印的位置
        let textRect = getWaterMarkCorner(corner: corner, margin: margin, waterMarkSize: textSize)
        
        // 开始给图片添加文字水印
        UIGraphicsBeginImageContext(imageSize)
        
        // 图片绘制到画布上
        self.draw(in: CGRect(origin: CGPoint.zero, size: imageSize))
        
        // 文字绘制到画布上
        NSString(string: waterMarkText).draw(in: textRect, withAttributes: textAttributes)
        
        // 生成新图片
        let waterMarkedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return waterMarkedImage!
    }
    
    
    /// 添加图片水印
    ///
    /// - Parameters:
    ///   - waterImage: 水印图片
    ///   - corner: 位置
    ///   - margin: 间距
    func createImageWaterMark(waterImage:UIImage, corner:WaterMarkCorner = .TopLeft, margin:CGPoint = CGPoint(x: 20, y: 20)) -> UIImage {
        
        // 开启画布
        UIGraphicsBeginImageContext(self.size)
        
        // 将原图绘制到画布上
        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))
        
        // 计算水印的位置
        let waterRect = getWaterMarkCorner(corner: corner, margin: margin, waterMarkSize: waterImage.size)
        
        // 将水印图片绘制到画布上
        waterImage.draw(in: waterRect)
        
        // 生成新图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
    
    
    /// 计算水印位置
    ///
    /// - Parameters:
    ///   - corner: 水印方位
    ///   - margin: 间距
    ///   - targetSize: 水印大小
    private func getWaterMarkCorner(corner:WaterMarkCorner, margin:CGPoint, waterMarkSize:CGSize) -> CGRect {

        var newRect = CGRect(origin: CGPoint.zero, size: waterMarkSize)
    
        switch corner {
        case .TopLeft:
            newRect.origin = CGPoint(x: margin.x, y: margin.y)
        case .TopRight:
            newRect.origin = CGPoint(x: self.size.width - waterMarkSize.width - margin.x, y: margin.y)
        case .BottomLeft:
            newRect.origin = CGPoint(x: margin.x, y: self.size.height - waterMarkSize.height - margin.y)
        case .BottomRight:
            newRect.origin = CGPoint(x: self.size.width - waterMarkSize.width - margin.x, y: self.size.height - waterMarkSize.height - margin.y)
        }
        
        return newRect
    }
    
}
