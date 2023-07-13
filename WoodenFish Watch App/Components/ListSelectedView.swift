//
//  ListSelectedView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/30.
//

import SwiftUI

struct ListSelectedView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userModel:UserModel
    @Binding var currentSelect:Int
    var items:[String] = [String]()
    @State var isSelected:[Bool]
    var body: some View {
        VStack{
            Button{
                dismiss()
            }label: {
                Text("取消")
                    .foregroundColor(.white)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.leading,12)
            List(0 ..< items.count){ index in
                AShakeView(title: items[index],isSelected: $isSelected[index])
                    .onTapGesture {
                        select(index: index)
                    }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            isSelected = Array(repeating: false, count: items.count)
            select(index: currentSelect)
        }
    }
    
    func select(index:Int){
        isSelected = Array(repeating: false, count: items.count)
        isSelected[index] = true
        currentSelect = index
    }
}

struct ListSelectedView_Previews: PreviewProvider {
    static var previews: some View {
        ListSelectedView(currentSelect: .constant(0),isSelected: [true])
    }
}
