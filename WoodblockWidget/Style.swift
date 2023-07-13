//
//  Style.swift
//  Woodblock
//
//  Created by 陈沈杰 on 2022/12/9.
//

import Foundation
import SwiftUI

struct Style{
    var id:Int
    var image:Image
    var backgroundColor:Color
}

let styles = [
    Style(id: 0, image: Image("woodenfish"), backgroundColor: .black),
    Style(id: 1, image: Image("woodenfish1"),backgroundColor: Color(red: 0.12, green: 0.12, blue: 0.12)),
    Style(id: 2, image: Image("woodenfish2"),backgroundColor: Color(red: 0.02, green: 0.02, blue: 0.01)),
    Style(id: 3, image: Image("woodenfish4"),backgroundColor: Color(red: 0.95, green: 0.96, blue: 0.98)),
    Style(id: 4, image: Image("woodenfish5"),backgroundColor: Color(red: 0.32, green: 0.42, blue: 1)),
    Style(id: 5, image: Image("woodenfish6"), backgroundColor: Color(red: 0.9, green: 0.45, blue: 0.26)),
    Style(id: 6, image: Image("woodenfish7"), backgroundColor: Color(red: 1, green: 0.8, blue: 0.7)),
    Style(id: 7, image: Image("woodenfish8"), backgroundColor: Color(red: 0.65, green: 0.9, blue: 0.91)),
    Style(id: 8, image: Image("woodenfish9"), backgroundColor: Color(red: 0.99, green: 0.95, blue: 0.93)),
    
    //乐器
    Style(id: 9, image: Image("deer"), backgroundColor: Color(red: 0.9, green: 0.87, blue: 0.83)),
    
    //动物
    Style(id: 10, image: Image("fog"), backgroundColor: Color(red: 0.75, green: 0.91, blue: 0.71)),
    Style(id: 11, image: Image("cat"), backgroundColor: Color(red: 0.97, green: 0.87, blue: 0.75)),
    Style(id: 12, image: Image("corgi"), backgroundColor: Color(red: 0.94, green: 0.94, blue: 0.94)),
    Style(id: 13, image: Image("dog"), backgroundColor: Color(red: 0.28, green: 0.28, blue: 0.28)),
    //自然
    Style(id: 14, image: Image("water"), backgroundColor: Color(red: 0.82, green: 0.95, blue: 0.99)),
    //其他
    Style(id: 15, image: Image("heart"), backgroundColor: Color(red: 0.92, green: 0.85, blue: 0.75)),
    Style(id: 16, image: Image("kiss"), backgroundColor: Color(red: 0.82, green: 0.65, blue: 0.45))
]
