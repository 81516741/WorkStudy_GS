//
//  Extension.swift
//  iMTC-Swift
//
//  Created by ld on 2018/1/3.
//  Copyright © 2018年 ld. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageWithColor(color:UIColor,size:CGSize)->UIImage{
        let rect = CGRect(x:0,y:0,width:size.width,height:size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

extension UIColor {
    class func color(value:CGFloat) -> UIColor {
        return UIColor.init(red: value/255.0, green: value/255.0, blue: value/255.0, alpha: 1.0)
    }
    
    class func color(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    class func blueThemeColor() -> UIColor {
        return UIColor.color(r: 65, g: 135, b: 255)
    }

}
