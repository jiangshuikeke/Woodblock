//
//  AShakeView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import SwiftUI

struct AShakeView: View {
    var title:String = ""
    @Binding var isSelected:Bool
    var body: some View {
        ZStack{
            Text(title)
                .padding(.leading,12)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .leading)
            Image(systemName: "checkmark")
                .bold()
                .foregroundColor(.white)
                .padding(.trailing,19)
                .opacity(isSelected ?1.0:0.0)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .trailing)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .leading)
        
       
    }
}

struct AShakeView_Previews: PreviewProvider {
    static var previews: some View {
        AShakeView(isSelected: .constant(false))
    }
}
