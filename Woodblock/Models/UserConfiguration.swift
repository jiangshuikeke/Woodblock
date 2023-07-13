//
//  Configuration.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/23.
//

import Foundation
import UIKit

@objcMembers
class UserConfiguration:NSObject{
        
    var count:Int = 0
    var styleIndex:Int = 0
    var isShowWord:Bool = true
    var showWord:String = ""
    var isAutoKnock:Bool = false
    var autoKnockIndex:Int = 0
    var autoKnockInterval:CGFloat = 1.0
    var stopKnockIndex:Int = 0
    var stopKnockDate:Date = Date()
    var stopKnockTime:Int = 0{
        didSet{
            if stopKnockTime < 0{
                stopKnockTime = 0
            }
        }
    }
    var deviationInterval:CGFloat = 0.0
    var isRandomVolume:Bool = false
    var isShowCounter:Bool = true
    var isScreenOn:Bool = false
    var vibratorIndex:Int = 0
    var shakeIndex:Int = 0
    
    override init() {
        super.init()
    }
    
    convenience init(dict:[String:Any]){
        self.init()
        setValuesForKeys(dict)
    }
    
    override class func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    private var filePath:String{
        //保存路径
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        return (path as NSString).appendingPathComponent("config.plist")
    }
    
    
    public var userDict:[String:Any]{
        let keys = ["count","styleIndex","isShowWord","showWord","isAutoKnock","autoKnockIndex","autoKnockInterval","stopKnockIndex","stopKnockDate","stopKnockTime","deviationInterval","isRandomVolume","isShowCounter","isScreenOn","vibratorIndex","shakeIndex"]
        return dictionaryWithValues(forKeys: keys)
    }
    
    func saveToPlist(){
        let dict = NSDictionary(dictionary: userDict)
        do{
            try dict.write(to: URL(filePath: filePath))
        }catch let error{
            print(error)
        }
    }
    
    //MARK: - 自身属性相关
    
    ///自动敲击名称
    public var autoKnockName:String{
        switch autoKnockIndex{
        case 0:
            return "自由"
        case 1:
            return "深邃"
        case 2:
            return "生命"
        case 3:
            return "乐章"
        case 4:
            return "迸发"
        default:
            return "自由"
        }
    }
    
    ///获取摇晃的强度
    public var shakeLevel:(CGFloat,CGFloat){
        var x = 0.0,y = 0.0
        switch shakeIndex{
        case 1:
            x = 1.0
            y = 1.0
            break
        case 2:
            x = 1.3
            y = 1.3
            break
        case 3:
            x = 1.6
            y = 1.6
            break
        default:
            break
        }
        return (x,y)
    }
    
    ///停止日期
    public func stopDate(index:Int) -> Date{
        let minute:TimeInterval = 60
        switch index{
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
    
    ///震动强度
    public var vibratorLevel:UIImpactFeedbackGenerator.FeedbackStyle{
        var style:UIImpactFeedbackGenerator.FeedbackStyle = .soft
        switch vibratorIndex{
        case 1:
            style = .soft
            break
        case 2:
            style = .medium
            break
        case 3:
            style = .heavy
            break
        default:
            style = .soft
            break
        }
        return style
    }
    var tempCount:Int = 0
    ///自动敲击是否停止
    public var isAutoStop:Bool{
        if stopKnockIndex == 2{
            return tempCount == 0
        }else if stopKnockIndex == 1{
            return stopKnockDate < Date()
        }else{
            return false
        }
    }
    
    ///根据当前下标返回自动敲击间隔
    public var autoInterval:CGFloat{
        switch autoKnockIndex{
        case 0:
            return 1.0
        case 1:
            return 2.4
        case 2:
            return 1.8
        case 3:
            return 1.2
        case 4:
            return 0.6
        default:
            return 1.0
        }
    }
    
}
