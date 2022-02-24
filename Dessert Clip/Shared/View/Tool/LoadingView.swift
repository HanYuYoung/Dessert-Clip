//
//  LoadingView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/3.
//

import SwiftUI

struct LoadingView: View {
    @State var rotateBlueCircle = false
    let loadingDur = 1.0
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 1/10, to: 1)
                .stroke(Color("AccentColor"), lineWidth: 4)
                .frame(width: 30,height: 30)
                .rotationEffect(.degrees(rotateBlueCircle ? 0 : -360))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false).speed(3))
                .onAppear {
                    rotateBlueCircle.toggle()
                }
        }
        .padding(10)
        .padding(.trailing, 20)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
