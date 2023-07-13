//
//  Global.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/21.
//

import Foundation
import UIKit
import AVFAudio

//MARK: - HUE
let BackgroundColor:UIColor = UIColor(hexStr: "0x1E1E1E")


//MARK: - 尺寸 布局
let FontBody = UIFont.systemFont(ofSize: 14)
let ScreenWidth:CGFloat = UIScreen.main.bounds.width
let ScreenHeight:CGFloat = UIScreen.main.bounds.height
let MarginPadding:CGFloat = 24.0
let ItemSpacing:CGFloat = 8.0
///状态栏高度
var StatusHeight : CGFloat {
    let scence = UIApplication.shared.connectedScenes.first as! UIWindowScene
    let manager = scence.statusBarManager
    return manager?.statusBarFrame.height ?? 0
}

let CornerRadius:CGFloat = 8.0

//MARK: - 系统有关
let SystemVolume:Float = AVAudioSession.sharedInstance().outputVolume
var RandomVolume:Float{
    let ratio = (1 + Float(arc4random() % 6) / 10)
    return SystemVolume * ratio
}
//MARK: - 通知
let UserConfigurationChange = Notification.Name("UserConfigurationChange")
let PauseAutoKonck = Notification.Name("PauseAutoKonck")

//开发者
let Email = "q952225629@gmail.com"

let IsShowCounter = UserDefaults.standard.bool(forKey: "isShowCounter")
let Version = "木鱼v1.0.0"

var SumCount:Int{
    UserDefaults.standard.integer(forKey: "SumCount")
}
