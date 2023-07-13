//
//  UIView+Extension.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/23.
//

import Foundation
import UIKit

extension UIView{
    convenience init(backgroundColor:UIColor = UIColor(red: 0.17, green: 0.17, blue: 0.18, alpha: 1) ,cornerRadius:CGFloat){
        self.init()
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
