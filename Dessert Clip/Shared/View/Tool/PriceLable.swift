//
//  PriceLable.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/3.
//

import SwiftUI

struct PriceLable: View {
    var price = 0
    
    var body: some View {
        HStack{
            Group {
                Text("¥")
                    .fontWeight(.semibold)
                Text("\(price)")
                    .fontWeight(.semibold)
            }
            .font(.system(size: 32))
            .foregroundColor(Color("subText"))
        }
    }
}

struct PriceLable_Previews: PreviewProvider {
    static var previews: some View {
        PriceLable(price: drinksData[0].menus[0].price)
            
    }
}
