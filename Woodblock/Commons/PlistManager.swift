//
//  PlistManager.swift
//  WoodenFish
//
//  Created by 陈沈杰 on 2022/11/23.
//

import Foundation

class PlistManager{
    static let shared:PlistManager = PlistManager()
    private init(){
        
    }
    
    private var userFilePath:String{
       return filePathWith(name: "config")
    }
    
    private var styleFilePath:String{
        return filePathWith(name: "styles")
    }
}

extension PlistManager{
    func loadUserConfiguration() -> UserConfiguration{
        var config:UserConfiguration = UserConfiguration()
        let fileManager = FileManager()
        if fileManager.fileExists(atPath: userFilePath){
            //读取数据
            if let dict = NSDictionary(contentsOf: URL(filePath: userFilePath)){
                config = UserConfiguration(dict: dict as! [String : Any])
            }
        }else{
            config.saveToPlist()
        }
        return config
    }
    
    ///显示展现在设置乐器中
    func loadSettingStyles() -> [Bool]{
        let fileManager = FileManager()
        var arr = Array(repeating: true, count: woodenFishs.count)
//        arr[0] = true
        if fileManager.fileExists(atPath: styleFilePath){
            if let styles = NSArray(contentsOf: URL(filePath: styleFilePath)) as? [Bool]{
                return styles
            }
        }else{
            saveSettingStylesIsShow(array: arr)
        }
        return arr
    }
    
    func saveSettingStylesIsShow(array:[Bool]){
        try?NSArray(array: array).write(to: URL(filePath: styleFilePath))
    }
    
    func saveStyleIsShow(at index:Int,isShow:Bool){
        var arr = loadSettingStyles()
        arr[index] = isShow
        saveSettingStylesIsShow(array: arr)
    }
}

private extension PlistManager{
    func filePathWith(name:String) -> String{
        //保存路径
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        return (path as NSString).appendingPathComponent("\(name).plist")
    }
}

