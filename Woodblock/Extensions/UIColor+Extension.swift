//
//  UIColor+Extension.swift
//  Ancientmakeup
//
//  Created by 陈沈杰 on 2022/4/15.
//

import Foundation
import UIKit

extension UIColor{
    convenience init(hexStr:String,alpha:CGFloat = 1.0){
        var red:UInt64 = 0,green:UInt64 = 0,blue:UInt64 = 0
        var hex:NSString
        if hexStr.hasPrefix("0x") || hexStr.hasPrefix("0X"){
            let index = "0x".endIndex
            hex = hexStr[index ..< hexStr.endIndex] as NSString
        }else{
            hex = hexStr as NSString
        }
        
        Scanner(string: hex.substring(with: NSRange(location: 0, length: 2))).scanHexInt64(&red)
        Scanner(string: hex.substring(with: NSRange(location: 2, length: 2))).scanHexInt64(&green)
        Scanner(string: hex.substring(with: NSRange(location: 4, length: 2))).scanHexInt64(&blue)
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    ///随机颜色
    public var randColor:UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    ///获取当前颜色的ARGB数值
    var alpha:CGFloat {
        return cgColor.components?.last ?? 1
    }
    var redValue:CGFloat {
        return cgColor.components?.first ?? 0
    }
    
    var greenValue:CGFloat {
        return cgColor.components?[1] ?? 0
    }
    
    var blueValue:CGFloat {
        return cgColor.components?[2] ?? 0
    }
    
    
    
}
