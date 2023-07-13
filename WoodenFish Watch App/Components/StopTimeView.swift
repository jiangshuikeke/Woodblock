//
//  StopTimeView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/29.
//

import SwiftUI

struct StopTimeView: View {
    let maxValue = 5.0
    var title:String = "停止次数"
    @Binding var value:Int
    var body: some View {
        HStack{
            Text(title)
                .padding(.leading,12)
            Spacer()
            Text("\(value)")
            HStack{
                Button{
                    value += 1
                }label: {
                    Image(systemName: "plus")
                        .frame(width: 18,height: 18)
                }
                .buttonStyle(.plain)
                
                
                Divider()
                    .padding(.vertical,7)
                
                Button {
                    value -= 1
                    if value < 0{
                        value = 0
                    }
                } label: {
                    Image(systemName: "minus")
                        .frame(width: 18,height: 18)
                }
                .buttonStyle(.plain)
                
            }
            .padding(6)
            .background(
                RoundedRectangle(cornerRadius: 6,style: .continuous)
                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26))
                )
            .padding(6)
        }
        .backview()
    }
}

struct StopTimeView_Previews: PreviewProvider {
    static var previews: some View {
        StopTimeView(value: .constant(0))
    }
}
