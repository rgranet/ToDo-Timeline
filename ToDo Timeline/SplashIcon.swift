//
//  SplashIcon.swift
//  ToDo Timeline
//
//  Created by Ruben Granet on 22/08/2024.
//

import SwiftUI

struct SplashIcon: View {
    @State var show = false
    @State var show2 = false
    @State var scale: CGFloat = 1
    var body: some View {
        ZStack {
            TimeLineView()
                .mask {
                    Image(systemName: show2 ? "seal.fill" : "checkmark.seal.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .scaleEffect(scale)
                        .contentTransition(.symbolEffect)
                }
            
            Image(systemName: show2 ? "seal.fill" : "checkmark.seal.fill")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundStyle(.primary)
                .opacity(show ? 0 : 1)
                .scaleEffect(scale)
                .contentTransition(.symbolEffect)
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.spring) {
                    show2.toggle()
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.spring) {
                    show.toggle()
                    scale = 20
                }
            }
        })
    }
}

#Preview {
    SplashIcon()
}
