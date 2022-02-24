//
//  PayButton.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/11.
//

import SwiftUI

struct PayButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            HStack {
                
                Image(systemName: "creditcard.fill")
                        .font(.system(size: 35))
                    .frame(width: 80, height: 48)
                

                Text("支付")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .frame(minWidth: 80)
            }
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(lineWidth: 1.5)
//                    .foregroundColor(Color(.separator))
                    .foregroundColor(Color("unselect"))
            )
            .foregroundColor(colorScheme == .light ? .accentColor : Color(#colorLiteral(red: 0.6747239232, green: 0.6791606545, blue: 0.7062301636, alpha: 1)))
            
    }
}

struct PayButton_Previews: PreviewProvider {
    static var previews: some View {
        PayButton()
//            .preferredColorScheme(.dark)
    }
}
