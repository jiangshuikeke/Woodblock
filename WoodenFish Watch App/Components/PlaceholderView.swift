//
//  PlaceholderView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/30.
//

import SwiftUI

struct PlaceholderView: View {
    var title:String = ""
    var placeholder:String = ""
    var body: some View {
        HStack{
            Text(title)
                .frame(maxWidth: .infinity,alignment: .leading)
                
            Text(placeholder)
                .font(.callout)
                .foregroundColor(.secondary)
                
        }
        
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
