//
//  DrinkView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/8.
//

import SwiftUI

struct DrinkView: View {
    let drink : Drink
    
    var body: some View {
        VStack(spacing: 12){
            ZStack {
                Image(drink.name) //只需获取文件名,图片存放在Assets里面
                    .frame(width: 60, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 2)
                    )
            }
            Text(drink.name)
        }
    }
}

struct DrinkView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            DrinkView(drink: drinksData[1])
                .previewLayout(.sizeThatFits)
            DrinkView(drink: drinksData[3])
                .previewLayout(.sizeThatFits)
            DrinkView(drink: drinksData[2])
                .previewLayout(.sizeThatFits)
        }
    }
}
