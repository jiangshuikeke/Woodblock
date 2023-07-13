//
//  SwiftUIView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import SwiftUI

///用户配置
struct Config:Codable{
    var styleIndex:Int = 0
    var isShowCounter:Bool = true
    var isVibrator:Bool = false
    var isVolume:Bool = true
    var isShake:Bool = false
    var isShowWord:Bool = true
    var word:String = ""
    var shakeIndex:Int = 0
    //自动敲击
    var isAutoKnock:Bool = false
    var autoKnockIndex:Int = 0
    var stopKnockIndex:Int = 0
    var stopDateIndex:Int = 0
    var stopTime:Int = 1
    //间隔偏差
    var deviation:CGFloat = 0
    //总共敲击
    var sumCount:Int = 0
    
    
    
    public var isStopAutoKnock:Bool{
        if stopKnockIndex == 0{
            return false
        }else if stopKnockIndex == 1{
            return Date() > stopDate
        }else{
            return stopTime == 0
        }
    }
    
    public var stopDate:Date{
        let minute:TimeInterval = 60
        switch stopDateIndex{
            //自定义的时候直接返回当前日期
        case 1:
            return Date().advanced(by: 5 * minute)
        case 2:
            return Date().advanced(by: 10 * minute)
        case 3:
            return Date().advanced(by: 20 * minute)
        case 4:
            return Date().advanced(by: 30 * minute)
        default:
            return Date()
        }
    }
    
    public var shakeLevel:(CGFloat,CGFloat){
        switch shakeIndex{
        case 0:
            return (0.7,0.7)
        case 1:
            return (1.0,1.0)
        case 2:
            return (1.3,1.3)
        default:
            return (0.7,0.7)
        }
    }
    
    public var currentKnockInterval:CGFloat{
        let autoKnockInterval = [1.0,2.4,1.8,1.2,0.6]
        return autoKnockInterval[autoKnockIndex]
    }
}



