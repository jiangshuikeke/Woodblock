//
//  InstrumentsEditView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import SwiftUI

struct InstrumentsEditView: View {
    @EnvironmentObject var userModel:UserModel
    var body: some View {
        ZStack{
            NavigationBar(title: "隐藏音效")
            ScrollView(.vertical) {
                buttons
               
                Section {
                    ForEach( 0 ..< WoodenfishsCount){ index in
                        EditView(style: styles[index], isShow: $userModel.isShowStyles[index])
                    }
                } header: {
                    Text("禅")
                        .foregroundColor(.white.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading,12)
                        .padding(.top,16)
                        .padding(.bottom,8)
                }

                Section{
                    ForEach( WoodenfishsCount ..< WoodenfishsCount + InstrumentCount){ index in
                        EditView(style: styles[index], isShow: $userModel.isShowStyles[index])
                    }
                }header:{
                    Text("乐器")
                        .foregroundColor(.white.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading,12)
                        .padding(.top,16)
                        .padding(.bottom,8)
                }
                
                Section{
                    ForEach( WoodenfishsCount + InstrumentCount ..< WoodenfishsCount + InstrumentCount + AnimalCount){ index in
                        EditView(style: styles[index], isShow: $userModel.isShowStyles[index])
                    }
                }header:{
                    Text("动物")
                        .foregroundColor(.white.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading,12)
                        .padding(.top,16)
                        .padding(.bottom,8)
                }
                
                Section{
                    ForEach( WoodenfishsCount + InstrumentCount + AnimalCount ..< WoodenfishsCount + InstrumentCount + AnimalCount + NatureCount){ index in
                        EditView(style: styles[index], isShow: $userModel.isShowStyles[index])
                    }
                }header:{
                    Text("自然")
                        .foregroundColor(.white.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading,12)
                        .padding(.top,16)
                        .padding(.bottom,8)
                }
                
                Section{
                    ForEach( WoodenfishsCount + InstrumentCount + AnimalCount + NatureCount ..< styles.count){ index in
                        EditView(style: styles[index], isShow: $userModel.isShowStyles[index])
                    }
                }header:{
                    Text("其他")
                        .foregroundColor(.white.opacity(0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading,12)
                        .padding(.top,16)
                        .padding(.bottom,8)
                }
            }
            .offset(y:42)
        }
        .onDisappear{
            userModel.saveStyles()
        }
    }
    
    var buttons:some View{
        VStack{
            Button{
                userModel.isShowStyles[0] = !userModel.isShowStyles[0]
            }label: {
                Text(userModel.isShowStyles[0] ?"隐藏【木鱼】音效":"显示【木鱼】音效")
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            
            Button{
                userModel.isShowStyles = Array(repeating: false, count: styles.count)
                userModel.isShowStyles[0] = true
            }label: {
                Text("隐藏所有音效")
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            
            Button{
                userModel.isShowStyles = Array(repeating: true, count: styles.count)
            }label: {
                Text("展示所有音效")
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
        }
    }
}

struct InstrumentsEditView_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentsEditView()
    }
}
