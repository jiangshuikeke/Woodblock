//
//  EditView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/29.
//

import SwiftUI

struct EditView: View {
    var style:Style
    @Binding var isShow:Bool
    var body: some View {
        HStack{
            RoundedRectangle(cornerRadius: 8,style: .continuous)
                .frame(maxWidth: .infinity,minHeight: 58)
                .foregroundColor(style.backgroundColor)
                .overlay(
                    style.image
                        .resizable()
                        .frame(minWidth: 45,minHeight: 45)
                        .scaledToFit()
                )
                .padding(.trailing,25)
            
                
            if style.id != 0{
                Image(isShow ?"remove":"add")
                    .resizable()
                    .frame(width: 16,height: 16)
                    .onTapGesture {
                        isShow.toggle()
                    }
                    .padding(.trailing,25)
            }else{
                Rectangle()
                    .frame(width: 16,height: 16)
                    .padding(.trailing,25)
                    .foregroundColor(.black)
            }
            
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(style: styles[0],isShow: .constant(true))
    }
}
