//
//  AutoKnockView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/30.
//

import SwiftUI

struct AutoKnockView: View {
    @EnvironmentObject var userModel:UserModel
    
    let items = ["永不","时间","次数"]
    let dateItems = ["5分钟","10分钟","15分钟","20分钟"]
    let interval = ["自由","深邃","生命","乐章","迸发"]
    var body: some View {
        ScrollView {
            WithSwitch(isOn: $userModel.config.isAutoKnock, title: "自动敲击")
            
            NavigationLink {
                ListSelectedView(currentSelect: $userModel.config.autoKnockIndex, items: interval,isSelected: [true,false,false,false,false])
            } label: {
                PlaceholderView(title: "敲击间隔",placeholder:"\(userModel.config.currentKnockInterval)s")
            }
            DeviationView(value: $userModel.config.deviation)
            
            
            
            NavigationLink {
                ListSelectedView(currentSelect: $userModel.config.stopKnockIndex, items: items,isSelected: [true,false,false])
            } label: {
                PlaceholderView(title: "停止敲击",placeholder: items[userModel.config.stopKnockIndex])
            }
            if userModel.config.stopKnockIndex == 1{
                NavigationLink {
                    ListSelectedView(currentSelect: $userModel.config.stopDateIndex, items: dateItems,isSelected: [true,false,false,false])
                } label: {
                    PlaceholderView(title: "停止时间",placeholder: dateItems[userModel.config.stopDateIndex])
                }
            }
            if userModel.config.stopKnockIndex == 2{
                StopTimeView(value: $userModel.config.stopTime)
            }
        }
    }
}

struct AutoKnockView_Previews: PreviewProvider {
    static var previews: some View {
        AutoKnockView()
    }
}
