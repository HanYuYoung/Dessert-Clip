//
//  MenuListView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/9.
//

import SwiftUI

struct MenuListView: View {
    var menus : [DrinkMenu]
    
    @Binding var selection : Int
    @State var offset : CGFloat = .zero
    
    let spacing : CGFloat = 5
    let swipeWidth : CGFloat = 260
    let swipeHeight : CGFloat = 450
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: spacing) {
                ForEach(menus.indices) { index in
                    MenuCoverView(imgUrl: menus[index].imager[0].url)
                        .frame(width: swipeWidth, height: swipeHeight)
                        .scaleEffect(selection == index ? 1 : 0.8)
                        .animation(.easeInOut)
                        .transition(.slide)
                }
            }
        }
        .content.offset(x: offset)
        .frame(width: swipeWidth, alignment: .leading)
        .onAppear {
            offset  -= swipeWidth * CGFloat(selection)
        }
        .gesture(
            DragGesture()
                .onChanged{
                    offset = $0.translation.width - swipeWidth * CGFloat(selection)
                }
                .onEnded{ value in
                    if -value.predictedEndTranslation.width > swipeWidth / 2, selection < menus.count - 1 {
                        withAnimation(.easeOut) {
                            selection += 1
                        }
                    }
                    if value.predictedEndTranslation.width > swipeWidth / 2, selection > 0 {
                        withAnimation(.easeOut) {
                            selection -= 1
                        }
                    }
                    withAnimation(.easeOut) {
                        offset = -(swipeWidth + spacing) * CGFloat(selection)
                    }
                }
        )
    }
}


struct MenuListView_Previews: PreviewProvider {
    
    struct testView1 : View {
        @State  private var selection = 1
        
        var body: some View {
            VStack {
                MenuListView(menus: drinksData[5].menus, selection: $selection)
                Text(selection.description)
            }
        }
    }
    
    static var previews: some View {
        testView1()
    }
}
