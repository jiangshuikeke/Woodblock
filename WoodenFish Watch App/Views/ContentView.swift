//
//  ContentView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var userModel:UserModel
    var body: some View {
        TabView {
            NavigationStack{
              SettingView()
            }
            NavigationStack{
                HomeView()
            }
            NavigationStack{
                InstrumentView()
            }
        }
        .tabViewStyle(.page)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserModel())
    }
}
