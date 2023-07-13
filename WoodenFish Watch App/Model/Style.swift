//
//  Style.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import Foundation
import SwiftUI

struct Style:Identifiable{
    var id:Int
    var name:String
    var image:Image
    //底部标题颜色
    var nameColor:Color?
    //统计数字颜色
    var countColor:Color?
    //背景颜色
    var backgroundColor:Color
    //音频
    var audio:String = ""
}

let WoodenfishsCount = 9
let InstrumentCount = 1
let AnimalCount = 4
let NatureCount = 1
let OtherCount = 2

let styles = [
    Style(id: 0, name: "木鱼", image: Image("woodenfish"),backgroundColor: .black,audio: "000"),
    Style(id: 1, name: "木鱼1", image: Image("woodenfish1"),backgroundColor: Color(red: 0.12, green: 0.12, blue: 0.12),audio: "001"),
    Style(id: 2, name: "木鱼2", image: Image("woodenfish2"),backgroundColor: Color(red: 0.02, green: 0.02, blue: 0.01),audio: "003"),
    Style(id: 3, name: "木鱼3", image: Image("woodenfish4"),backgroundColor: Color(red: 0.95, green: 0.96, blue: 0.98),audio: "004"),
    Style(id: 4, name: "木鱼4", image: Image("woodenfish5"),backgroundColor: Color(red: 0.32, green: 0.42, blue: 1),audio: "005"),
    Style(id: 5, name: "木鱼5", image: Image("woodenfish6"), backgroundColor: Color(red: 0.9, green: 0.45, blue: 0.26),audio: "006"),
    Style(id: 6, name: "木鱼6", image: Image("woodenfish7"), backgroundColor: Color(red: 1, green: 0.8, blue: 0.7),audio: "007"),
    Style(id: 7, name: "木鱼7", image: Image("woodenfish8"), backgroundColor: Color(red: 0.65, green: 0.9, blue: 0.91),audio: "008"),
    Style(id: 8, name: "木鱼8", image: Image("woodenfish9"), backgroundColor: Color(red: 0.99, green: 0.95, blue: 0.93),audio: "009"),
    
    //乐器
    Style(id: 9, name: "麋鹿", image: Image("deer"), backgroundColor: Color(red: 0.9, green: 0.87, blue: 0.83),audio: "smallbell"),
    
    //动物
    Style(id: 10, name: "青蛙", image: Image("fog"), backgroundColor: Color(red: 0.75, green: 0.91, blue: 0.71),audio: "fog"),
    Style(id: 11, name: "猫咪", image: Image("cat"), backgroundColor: Color(red: 0.97, green: 0.87, blue: 0.75),audio: "cat"),
    Style(id: 12, name: "柯基犬", image: Image("corgi"), backgroundColor: Color(red: 0.94, green: 0.94, blue: 0.94),audio: "dog"),
    Style(id: 13, name: "狗狗", image: Image("dog"), backgroundColor: Color(red: 0.28, green: 0.28, blue: 0.28),audio: "dog1"),
    //自然
    Style(id: 14, name: "水滴", image: Image("water"), backgroundColor: Color(red: 0.82, green: 0.95, blue: 0.99),audio: "water"),
    //其他
    Style(id: 15, name: "心跳", image: Image("heart"), backgroundColor: Color(red: 0.92, green: 0.85, blue: 0.75),audio: "heart"),
    Style(id: 16, name: "亲吻", image: Image("kiss"), backgroundColor: Color(red: 0.82, green: 0.65, blue: 0.45),audio:"kiss")
    

]
