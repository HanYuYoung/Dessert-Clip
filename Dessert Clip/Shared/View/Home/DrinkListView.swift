//
//  DrinkListView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/8.
//

import SwiftUI

struct DrinkListView: View {
    let drinks : [Drink]
    
    @Binding var selection : Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators:false){
            HStack(spacing: 42,  content: {
                ForEach(drinks.indices) { index in
                    DrinkView(drink: drinks[index])
                        .foregroundColor(selection == index ? Color("drinkSelect") : Color("unselect"))
                        .scaleEffect(selection == index ? 1.05 : 1)
                        .onTapGesture {
                            withAnimation(Animation.interactiveSpring()){
                                self.selection = index
                            }
                        }
                }
            })
            .frame(height: 100)
            .padding(12)
        }
    }
}

struct DrinkListView_Previews: PreviewProvider {
    
    struct testView1: View {
        @State var selection : Int
        
        var body: some View {
            DrinkListView(drinks: drinksData, selection: $selection)
        }
    }
    
    static var previews: some View {
        testView1(selection: 2)
//            .preferredColorScheme(.dark)
    }
}
