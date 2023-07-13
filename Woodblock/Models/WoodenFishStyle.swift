//
//  WoodenFishStyle.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/21.
//

import Foundation
import UIKit
/**
 木鱼样式
 */
struct WoodenFishStyle{
    var id:Int
    var name:String
    var image:UIImage?
    //设置按钮颜色
//    var settingColor:UIColor
    //暂停按钮颜色
    var pauseColor:UIColor
    //底部标题颜色
//    var nameColor:UIColor
    //统计数字颜色
//    var countColor:UIColor
    var componentColor:UIColor
    //背景颜色
    var backgroundColor:UIColor
    
    //音频
    var audio:String = ""
}

let woodenCount = 9
let instrumentCount = 1
let animalCount = 4
let natureCount = 1
let otherCount = 2
///禅
let woodenFishs = [
    WoodenFishStyle(id: 0, name: "木鱼", image: UIImage(named: "woodenfish"), pauseColor: UIColor(hexStr: "0xF58587"), componentColor: UIColor(hexStr: "0xA7A7A7"), backgroundColor: .black,audio: "000"),
    WoodenFishStyle(id: 1, name: "木鱼1", image: UIImage(named: "woodenfish1"), pauseColor: UIColor(hexStr: "0xF58587"), componentColor: UIColor(hexStr: "0xD1A674"), backgroundColor: UIColor(hexStr: "0x1E1E1E"),audio: "001"),
    WoodenFishStyle(id: 2, name: "木鱼2", image: UIImage(named: "woodenfish2"), pauseColor: UIColor(hexStr: "0xF58587"), componentColor: UIColor(hexStr: "0xD2AF90"), backgroundColor: UIColor(hexStr: "0x060403"),audio: "003"),
    WoodenFishStyle(id: 3, name: "木鱼3", image: UIImage(named: "woodenfish4"), pauseColor: UIColor(hexStr: "0xF58587"), componentColor: UIColor(hexStr: "0x707491"), backgroundColor: UIColor(hexStr: "0xF1F4FB"),audio: "004"),
    WoodenFishStyle(id: 4, name: "木鱼4", image: UIImage(named: "woodenfish5"), pauseColor: UIColor(hexStr: "0xF58587"), componentColor: UIColor(hexStr: "0xFFCA02"), backgroundColor: UIColor(hexStr: "0x516BFE"),audio: "005"),
    WoodenFishStyle(id: 5, name: "木鱼5", image: UIImage(named: "woodenfish6"), pauseColor: UIColor(hexStr: "0xF58587"), componentColor: UIColor(hexStr: "0xFFCA02"), backgroundColor: UIColor(hexStr: "0xE67242"),audio: "006"),
    WoodenFishStyle(id: 6, name: "木鱼6", image: UIImage(named: "woodenfish7"), pauseColor: UIColor(hexStr: "0xF58587"), componentColor: UIColor(hexStr: "0xFE5B49"), backgroundColor: UIColor(hexStr: "0xFECCB3"),audio: "007"),
    WoodenFishStyle(id: 7, name: "木鱼7", image: UIImage(named: "woodenfish8"), pauseColor: UIColor(hexStr: "0xF58587"), componentColor: UIColor(hexStr: "0x0CB3D6"), backgroundColor: UIColor(hexStr: "0xA6E6E8"),audio: "008"),
    WoodenFishStyle(id: 8, name: "木鱼8", image: UIImage(named: "woodenfish9"), pauseColor: UIColor(hexStr: "0xF58587"), componentColor: UIColor(hexStr: "0x433937"), backgroundColor: UIColor(hexStr: "0xFDF3EE"),audio: "009"),
    //乐器
    WoodenFishStyle(id: 9, name: "麋鹿铃",image: UIImage(named: "deer"), pauseColor: UIColor(hexStr: "0xFF6B5B"), componentColor: UIColor(hexStr: "0xB2795E"), backgroundColor: UIColor(hexStr: "0xE6DFD4"),audio: "smallbell"),
    //动物
    WoodenFishStyle(id: 9, name: "青蛙", image: UIImage(named: "fog"), pauseColor: UIColor(hexStr: "0xFF6B5B"), componentColor: UIColor(hexStr: "0x383F51"), backgroundColor: UIColor(hexStr: "0xBEE9B4"),audio: "fog"),
    WoodenFishStyle(id: 14, name: "猫咪",image: UIImage(named: "cat"), pauseColor: UIColor(hexStr: "0xFF6B5B"), componentColor: UIColor(hexStr: "0x724C27"), backgroundColor: UIColor(hexStr: "0xF7DEBF"),audio: "kitty1"),
    WoodenFishStyle(id: 15, name: "柯基犬", image: UIImage(named: "corgi"),pauseColor: UIColor(hexStr: "0xFF6B5B"), componentColor: UIColor(hexStr: "0x192B3A"), backgroundColor: UIColor(hexStr: "0xEFEFEF"),audio: "dog1"),
    WoodenFishStyle(id: 13, name: "狗狗",image: UIImage(named: "dog"), pauseColor: UIColor(hexStr: "0xFF6B5B"), componentColor: UIColor(hexStr: "0xC3BAB3"), backgroundColor: UIColor(hexStr: "0x474747"),audio: "dog2"),
    //自然
    WoodenFishStyle(id: 16, name: "水滴", image: UIImage(named: "water"),pauseColor: UIColor(hexStr: "0xFF6B5B"), componentColor: UIColor(hexStr: "0x3282DB"), backgroundColor: UIColor(hexStr: "0xD1F3FC"),audio: "water"),
    //其他
    WoodenFishStyle(id: 12, name: "心跳",image: UIImage(named: "heart"), pauseColor: UIColor(hexStr: "0xFF6B5B"), componentColor: UIColor(hexStr: "0xFE506B"), backgroundColor: UIColor(hexStr: "0xEBDAC0"),audio: "heart"),
    WoodenFishStyle(id: 11, name: "亲吻",image: UIImage(named: "kiss"), pauseColor: UIColor(hexStr: "0xFF6B5B"), componentColor: UIColor(hexStr: "0x1E1E1E"), backgroundColor: UIColor(hexStr: "0xD1A674"),audio: "kiss")
]

///乐器

