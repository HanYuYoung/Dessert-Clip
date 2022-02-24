//
//  MenuTitleView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/3.
//

import SwiftUI

struct MenuTitleView: View {
    
    var menu : DrinkMenu
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack{
                Text("现在下单")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(Color("subText"))
                Image(systemName:"arrow.right")
            }
            
            Text(menu.name.description)
                .font(.system(size: 32))
                .foregroundColor(.accentColor)
                .fontWeight(.heavy)
            Spacer()
            
            PriceLable(price: menu.price)
                .padding()
        }
        .frame(width: 280, height: 200)
    }
}

struct MenuTitleView_Previews: PreviewProvider {
    static var previews: some View {
        MenuTitleView(menu: drinksData[1].menus[2])
            .previewLayout(.sizeThatFits)
    }
}
