//
//  WoodenFishApp.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import SwiftUI

@main
struct WoodenFish_Watch_AppApp: App {
    //在应用开始初始化
    @StateObject var userModel = UserModel()
    var body: some Scene {
        WindowGroup {
            //并且传递到子视图中
            ContentView()
                .environmentObject(userModel)
                .onDisappear{
                    userModel.saveConfig()
                    userModel.saveStyles()
                }
        }
    }
}
