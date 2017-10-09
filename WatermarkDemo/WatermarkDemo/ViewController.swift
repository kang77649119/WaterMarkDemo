//
//  ViewController.swift
//  WatermarkDemo
//
//  Created by 也许、 on 2017/10/8.
//  Copyright © 2017年 也许、. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var imgView:UIImageView = {
        let imgView:UIImageView = UIImageView(frame: CGRect(origin: CGPoint.init(x: self.view.center.x - 150, y: self.view.center.y - 150), size: CGSize(width: 300, height: 300)))
        imgView.tag = 99
        imgView.contentMode = .scaleAspectFill
//        imgView.image = UIImage(named: "test.jpeg")
        return imgView
    }()
    
    let text = "测试中文ABC123"
    let targetImage = UIImage(named : "test.jpeg")!
    
    @IBAction func leftTopTextWaterMark(_ sender: Any) {
        
        self.view.viewWithTag(99)?.removeFromSuperview()
        
        let image = targetImage.createTextWaterMark(waterMarkText: text, corner: .TopLeft, waterMarkTextColor: UIColor.blue, waterMarkTextFont: UIFont.systemFont(ofSize: 40))
        
        imgView.image = image
        self.view.addSubview(imgView)
        
    }
    
    @IBAction func rightBottomTextWaterMark(_ sender: Any) {
        
        self.view.viewWithTag(99)?.removeFromSuperview()
        let image = targetImage.createTextWaterMark(waterMarkText: text, corner: .BottomRight, waterMarkTextColor: UIColor.blue, waterMarkTextFont: UIFont.systemFont(ofSize: 40))
        
        imgView.image = image
        self.view.addSubview(imgView)
        
    }
    
    @IBAction func leftBottomImageWaterMark(_ sender: Any) {
        
        self.view.viewWithTag(99)?.removeFromSuperview()
        let waterMarkImage = UIImage(named: "test3")!
        let image = targetImage.createImageWaterMark(waterImage: waterMarkImage, corner: .BottomLeft)
        
        imgView.image = image
        self.view.addSubview(imgView)
        
    }
    
    @IBAction func rightBottomImageWaterMark(_ sender: Any) {
        
        self.view.viewWithTag(99)?.removeFromSuperview()
        let waterMarkImage = UIImage(named: "test3")!
        let waterMarkImage2 = UIImage(named: "test2")!
        let image = targetImage.createImageWaterMark(waterImage: waterMarkImage, corner: .BottomRight).createImageWaterMark(waterImage: waterMarkImage2, corner: .BottomLeft)
        
        imgView.image = image
        self.view.addSubview(imgView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

