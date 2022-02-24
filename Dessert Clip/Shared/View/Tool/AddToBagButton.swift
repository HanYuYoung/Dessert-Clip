//
//  AddToBagButton.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/10.
//

import SwiftUI

struct AddToBagButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {

            HStack(alignment: .center) {
                ZStack {
                    Circle().frame(width: 48, height: 48)
                    Image(systemName: "plus")
                        .font(.system(size: 23))
                        .foregroundColor(Color("currency"))
                }

                Text("加到购物袋")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .frame(minWidth: 150)
            }
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(lineWidth: 1)
//                    .foregroundColor(Color(.opaqueSeparator))
//                    .foregroundColor(Color("border"))
                    .foregroundColor(Color("unselect"))
            )
            .foregroundColor(colorScheme == .light ? .accentColor : Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
            .padding(5)

        
    }
}

struct AddToBagButton_Previews: PreviewProvider {
    static var previews: some View {
        AddToBagButton()
    }
}
