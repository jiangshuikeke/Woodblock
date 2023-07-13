//
//  BackView.swift
//  WoodenFish Watch App
//
//  Created by 陈沈杰 on 2022/11/28.
//

import SwiftUI

struct BackView:ViewModifier{
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 10,style: .continuous)
                    .foregroundColor(.white.opacity(0.13))
            )
    }
}

extension View{
    func backview() -> some View{
        modifier(BackView())
    }
}

