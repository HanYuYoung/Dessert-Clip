//
//  MenuTabPageView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/13.
//

import SwiftUI
import SDWebImageSwiftUI

struct MenuTabPageView: View {
    let menus : [DrinkMenu]
    
    @State private var index = 0
    
    var body: some View {
        
        TabView(selection: $index)  {
            ForEach(menus.indices) { (index)  in
                ZStack {
                    WebImage(url: URL(string: baseUrl + menus[index].imager[0].url))
                        .resizable()
                        .scaledToFit()
                }.tag(index)
            }
        }
        .frame(height: 320)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

    }
}

struct MenuTabPageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuTabPageView(menus: drinksData[0].menus)
        }
            
    }
}
