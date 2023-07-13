//
//  GroupMangager.swift
//  Woodblock
//
//  Created by 陈沈杰 on 2022/12/9.
//

import Foundation


let GroupDefaultID = "group.personal.starsea"
class GroupManager{
    static let shared = GroupManager()
    
    private let defaults = UserDefaults(suiteName: GroupDefaultID)
    
    var styleIndex:Int{
        set{
            defaults?.set(newValue, forKey: "styleIndex")
        }
        get{
            if let value = defaults?.value(forKey: "styleIndex") as? Int{
                return value
            }else{
                return 0
            }
        }
    }
}
