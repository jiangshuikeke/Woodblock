//
//  SettingView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var userModel:UserModel
    
    @State var isVibrator:Bool = true
    @State var isShake:Bool = true
    @State var deviationValue:CGFloat = 0.0
    @State var isShowCounter:Bool = true
    @State var isShowWord:Bool = true
    @State var word:String = "功德+1"
    
    let level:[String] = ["微动","随意","轻甩","用力"]
    
    @State var isDetail:Bool = false
    @State var stopTime:Int = 0
    let VersionName = "木鱼v1.0.0"
    var body: some View {
        ZStack{
            NavigationBar(title: "设置")
            ScrollView(.vertical){
//                Button{
//
//                }label: {
//                    Text("音量设置")
//                        .frame(maxWidth: .infinity,maxHeight: 38,alignment: .leading)
//                }
                
                WithSwitch(isOn: $userModel.config.isVibrator, title: "手表震动")
                
                WithSwitch(isOn: $userModel.config.isShake, title: "摇晃检测")
                
                NavigationLink {
                    ListSelectedView(currentSelect: $userModel.config.shakeIndex,items: level,isSelected: [false,true,true,true])
                } label: {
                    Text(level[userModel.config.shakeIndex])
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                NavigationLink {
                    AutoKnockView()
                } label: {
                    Text("自动敲击")
                        .frame(maxWidth: .infinity,alignment: .leading)
                }

                WithSwitch(isOn: $userModel.config.isShowCounter, title: "显示计数")
                
                
                WithSwitch(isOn: $userModel.config.isShowWord, title: "显示文本")
                
                TextField("敲击文本", text: $userModel.config.word)
                
                Text(VersionName)
                
                    
            }
            .offset(y:isDetail ?0:42)
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .onDisappear{
            userModel.saveConfig()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(UserModel())
    }
}
