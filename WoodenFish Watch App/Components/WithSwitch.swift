//
//  WithSwitch.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import SwiftUI

struct WithSwitch: View {
    @Binding var isOn:Bool
    var title:String
    var body: some View {
        HStack{
            Text(title)
                .font(.body)
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(maxWidth: .infinity,alignment:.leading)
                .padding(.leading,12)
                
            Toggle("", isOn: $isOn)
                .padding(.trailing,12)
        }
        .frame(maxWidth: .infinity, minHeight: 44)
        .backview()
    }
}

struct WithSwitch_Previews: PreviewProvider {
    static var previews: some View {
        WithSwitch(isOn: .constant(false), title: "")
    }
}
