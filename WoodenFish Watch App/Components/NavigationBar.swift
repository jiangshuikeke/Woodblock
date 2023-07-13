//
//  NavigationBar.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import SwiftUI

struct NavigationBar: View {
    var title:String
    var body: some View {
        ZStack(alignment: .topLeading){
            Text(title)
                .font(Font.system(size: 24))
                .foregroundColor(Color(UIColor(red: 0.42, green: 0.53, blue: 1, alpha: 1)))
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
                .padding(.leading,11)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "设置")
    }
}
