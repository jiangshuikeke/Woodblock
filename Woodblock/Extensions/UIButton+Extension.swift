//
//  UIButton+Extension.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/21.
//

import Foundation
import UIKit

extension UIButton{
    convenience init(image:String,title:String) {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: image)
        let attrString = AttributedString(title,attributes: AttributeContainer([.font:FontBody,.foregroundColor:UIColor(red: 1, green: 1, blue: 1, alpha: 1)]))
        config.attributedTitle = attrString
        config.imagePadding = ItemSpacing
        config.imagePlacement = .leading
        self.init(configuration: config)
        isUserInteractionEnabled = false
    }
}
