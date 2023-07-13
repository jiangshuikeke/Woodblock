//
//  DeviationView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import SwiftUI

struct DeviationView: View {
    let maxValue = 5.0
    var title:String = "间隔偏差度"
    @Binding var value:CGFloat
    var body: some View {
        HStack{
            Text(title)
                .padding(.leading,12)
            Spacer()
            Text(String(format: "%1.2f", value))
            HStack{
                Button{
                    value += 0.5
                    if value > 5{
                        value = maxValue
                    }
                }label: {
                    Image(systemName: "plus")
                        .frame(width: 18,height: 18)
                }
                .buttonStyle(.plain)
                
                
                Divider()
                    .padding(.vertical,7)
                
                Button {
                    value -= 0.5
                    if value == 0{
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

struct DeviationView_Previews: PreviewProvider {
    static var previews: some View {
        DeviationView(value: .constant(0.0))
    }
}
