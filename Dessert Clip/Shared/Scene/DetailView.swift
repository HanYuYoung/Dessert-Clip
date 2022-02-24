//
//  DetailView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/10.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    let menu : DrinkMenu
    @State var showMore = false
    @State var dragOffset: CGFloat = .zero
    @Binding var showDetail : Bool
    
    var body: some View {
            ZStack(alignment:.bottom) {
                Color("currency")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
//                    Color("maskOverlay")
                    HStack{
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color("AccentColor"))
                            .padding(.vertical, 55)
                            .padding(.horizontal, 30)
                            .onTapGesture(count: 1, perform: {
                                withAnimation {
                                    showDetail.toggle()
                                }
                            })
                        Spacer()
                    }
                    Spacer()
                }
                
                VStack {
                    WebImage(url: URL(string: baseUrl + menu.imagec[0].url))
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: 380)
                        .padding(.top, 120)
                        .padding(.bottom, 24)
                        .animation(.easeIn)
                    
                    Text(menu.describe)
                        .multilineTextAlignment(.leading)
                        .frame(width: screen.width-32)
                        .foregroundColor(Color("AccentColor"))
                        .font(.title2)
                    Spacer()
                }

                MenuOptionsView(menu: menu, containerSelection: 0,need_tablewareSelection: 0,conditionSelection: 0,flavorSelection: 0,practiceSelection: 0,sweetSelection: 0,tea_baseSelection: 0,tea_topSelection: 0, showMore: $showMore, showDetail: $showDetail)
                    
            }
            .ignoresSafeArea()
            .background(Blur(style: .extraLight))
            .transition(pushTransition)
            .animation(.spring())
        }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(menu: drinksData[3].menus[1],showMore: false, showDetail: .constant(true))
            .preferredColorScheme(.dark)
    }
}
