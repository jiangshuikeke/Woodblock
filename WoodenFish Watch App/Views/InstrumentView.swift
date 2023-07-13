//
//  InstrumentView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import SwiftUI

struct InstrumentView: View {
    @EnvironmentObject var userModel:UserModel
    var body: some View {
        VStack{
            NavigationBar(title: "乐器")
            List{
                NavigationLink {
                    InstrumentsEditView()
                } label: {
                    Text("乐器编辑")
                }
            }
            instrumentsList
            
            
        }
        .onDisappear{
            userModel.saveConfig()
            userModel.saveStyles()
        }
    }
    
    var instrumentsList:some View{
        ScrollView{
            ForEach(styles){ style in
                if userModel.isShowStyles[style.id]{
                    RoundedRectangle(cornerRadius: 8,style: .continuous)
                        .foregroundColor(style.backgroundColor)
                        .overlay {
                            style.image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth:.infinity,maxHeight: 38)
                        }
                        .overlay(userModel.config.styleIndex == style.id ?maskView:nil)
                        .frame(height: 44)
                        .padding(.horizontal,2)
                        .onTapGesture {
                            selectStyle(style: style)
                        }
                }
                    
            }
        }
        
    }
    
    var maskView:some View{
        RoundedRectangle(cornerRadius: 8,style: .continuous)
            .stroke(
                .blue.opacity(1),lineWidth: 1.5
            )
            .background(.blue.opacity(0.1))
    }
    
    func selectStyle(style:Style){
        userModel.config.styleIndex = style.id
    }
}

struct InstrumentView_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentView()
            .environmentObject(UserModel())
    }
}
