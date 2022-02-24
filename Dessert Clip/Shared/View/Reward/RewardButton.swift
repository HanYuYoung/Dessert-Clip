//
//  RewardButton.swift
//  Dessert
//
//  Created by Han Yu Young! on 2021/3/12.
//

import SwiftUI

struct RewardButton : View {
    @Binding var show: Bool
    var body: some View {
        return
            Button(action: { self.show.toggle() }) {
                HStack {
                    Image("Menu")
                        .renderingMode(.template)
                        .frame(width: 100,height: 100)
                        .foregroundColor(.accentColor)
                    Spacer()
                        
                }.padding(15)
            }
            .frame(width: 100, height: 70)
//            .background(Color.accentColor)
            .cornerRadius(30)
            .clipShape(Capsule()).overlay(Capsule().stroke(Color.accentColor, lineWidth: 3))
    }
}
struct RewardButton_Previews: PreviewProvider {
    static var previews: some View {
        RewardButton(show: .constant(true))
            .preferredColorScheme(.light)
            
    }
}
