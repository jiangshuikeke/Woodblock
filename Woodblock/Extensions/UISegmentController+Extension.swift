//
//  UISegmentController+Extension.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/22.
//

import Foundation
import UIKit

extension UISegmentedControl{
    convenience init(titles:[String],font:UIFont = FontBody) {
        self.init(items: titles)
        setTitleTextAttributes([.font : font,.foregroundColor : UIColor.white], for: .normal)
        selectedSegmentTintColor = UIColor(hexStr: "0x737279")
    }
}
