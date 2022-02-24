//
//  MenuOptionsView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/10.
//

import SwiftUI
import Request

struct MenuOptionsView: View {
    
    let menu : DrinkMenu
    @State var containerSelection = 0
    @State var need_tablewareSelection = 0
    @State var conditionSelection = 0
    @State var flavorSelection  = 0
    @State var practiceSelection  = 0
    @State var sweetSelection  = 0
    @State var tea_baseSelection  = 0
    @State var tea_topSelection  = 0
    @Binding var showMore : Bool
    @Binding var showDetail : Bool
    
    @State var loading = false
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var store : Store
    
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 42, height: 6)
                    .opacity(0.15)
                    .padding(.top, 20)
                
                VStack(alignment: .center) {
                    MenuTitle(name: menu.name)
                        .frame(height: 80)
                    if !showMore {
                        PriceLable(price: menu.price)
                            .transition(.asymmetric(insertion: .slide, removal: .opacity))
                    }
                }
                .padding()
                
                VStack(alignment: .leading){
                    if showMore {
                        if !menu.need_tableware.isEmpty {
                            VStack(alignment: .leading) {
                                Text("绿色喜茶")
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                                    .foregroundColor(colorScheme == .light ? Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)) : Color(#colorLiteral(red: 0.3944879466, green: 0.6949355007, blue: 0.2093639099, alpha: 1)))
                                    .frame(height: 10)
                                    .padding(.leading, 6)
                                NeedTablewareOptionsView(selection: $need_tablewareSelection, options: menu.need_tableware)
                            }
                            .padding(.leading, 10)
                            .animation(nil)
                        }
                        
                        if !menu.condition.isEmpty {
                            VStack(alignment: .leading) {
                                Text("状态")
                                    .font(.system(size: 24))
                                    .frame(height: 10)
                                    .padding(.leading, 6)
                                ConditionOptionsView(selection: $conditionSelection, options: menu.condition)
                            }
                            .padding(.leading, 10)
                            .animation(nil)
                        }
                        
                        if !menu.flavor.isEmpty {
                            VStack(alignment: .leading) {
                                Text("口味")
                                    .font(.system(size: 24))
                                    .frame(height: 10)
                                    .padding(.leading, 6)
                                FlavorOptionsView(selection: $flavorSelection, options: menu.flavor)
                            }
                            .padding(.leading, 10)
                            .animation(nil)
                        }
                        
                        if !menu.practice.isEmpty {
                            VStack(alignment: .leading) {
                                Text("做法")
                                    .font(.system(size: 24))
                                    .frame(height: 10)
                                    .padding(.leading, 6)
                                PracticeOptionsView(selection: $practiceSelection, options: menu.practice)
                            }
                            .padding(.leading, 10)
                            .animation(nil)
                        }
                        
                        if !menu.sweet.isEmpty {
                            VStack(alignment: .leading) {
                                Text("甜度")
                                    .font(.system(size: 24))
                                    .frame(height: 10)
                                    .padding(.leading, 6)
                                SweetOptionsView(selection: $sweetSelection, options: menu.sweet)
                            }
                            .padding(.leading, 10)
                            .animation(nil)
                        }
                        
                        if !menu.tea_base.isEmpty && menu.tea_base.count > 1{
                            VStack(alignment: .leading) {
                                Text("茶底")
                                    .font(.system(size: 24))
                                    .frame(height: 10)
                                    .padding(.leading, 6)
                                TeaBaseOptionsView(selection: $tea_baseSelection, options: menu.tea_base)
                                
                            }
                            .padding(.leading, 10)
                            .animation(nil)
                        }
                        
                        if !menu.tea_top.isEmpty {
                            VStack(alignment: .leading) {
                                Text("茶顶")
                                    .font(.system(size: 24))
                                    .frame(height: 10)
                                    .padding(.leading, 6)
                                TeaTopOptionsView(selection: $tea_topSelection, options: menu.tea_top)
                            }
                            .padding(.leading, 10)
                            .animation(nil)
                        }
                        
                        if !menu.container.isEmpty {
                            VStack(alignment: .leading) {
                                Text("分装")
                                    .font(.system(size: 24))
                                    .frame(height: 10)
                                    .padding(.leading, 6)
                                ContainerOptionsView(selection: $containerSelection, options: menu.container)
                            }
                            .padding(.leading, 10)
                            .animation(nil)
                        }
                    }
                }
                .animation(nil)
                
                
                if loading {
                    LoadingView()
                }
                
                AddToBagButton()
                    .padding(.bottom, 10)
                    .onTapGesture{
                        createOrder()
                    }
                
            }
            .ignoresSafeArea()
            .background(Blur(style: .systemMaterial))
            .cornerRadius(30)
            .shadow(color: .clear, radius: 2, x: 0, y: 1)
        }
        .offset(y: -10)
        .gesture(
            DragGesture()
                .onEnded({ (value) in
                    if (abs(value.translation.height) > 10) {
                        withAnimation(Animation.spring()) {
                            showMore.toggle()
                        }
                    }
                })
        )
        .onTapGesture{
            showMore.toggle()
        }
    }
    
    func createOrder()  {
        loading = true
        
        var newOrder = Order()
        newOrder.menu_id = menu.id
        newOrder.menu_name = menu.name
        newOrder.price = menu.price
        newOrder.quantity = 1
        newOrder.imgUrl = menu.imager[0].formats["thumbnail"]!.url
        newOrder.status = 0
        
        if !menu.container.isEmpty {
            newOrder.container_option = menu.container[containerSelection].name
        }
        if !menu.need_tableware.isEmpty {
            newOrder.need_tableware_option = menu.need_tableware[need_tablewareSelection].name
        }
        if !menu.condition.isEmpty{
            newOrder.condition_option = menu.condition[conditionSelection].name
        }
        if !menu.flavor.isEmpty{
            newOrder.flavor_option = menu.flavor[flavorSelection].name
        }
        if !menu.practice.isEmpty{
            newOrder.practice_option = menu.practice[practiceSelection].name
        }
        if !menu.sweet.isEmpty{
            newOrder.sweet_option = menu.sweet[sweetSelection].name
        }
        if !menu.tea_base.isEmpty{
            newOrder.tea_base_option = menu.tea_base[tea_baseSelection].name
        }
        if !menu.tea_top.isEmpty{
            newOrder.tea_top_option = menu.tea_top[tea_topSelection].name
        }
        
        Request {
            Url(Network.createOrder)
            Method(.post)
            Header.ContentType(.json)
            RequestBody(newOrder)
        }
        .onJson { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    loading = false
                    store.currentOrder = newOrder
                    store.action = .add //订单增加的全局通知
                    showDetail.toggle()
                }
            }
        }
        .onError { (error) in
            print("Error create：",error)
            withAnimation {
                loading = false
            }
        }
        .call()
    }
}

struct MenuOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        MenuOptionsView(menu: drinksData[1].menus[0],containerSelection: 0,need_tablewareSelection: 0,conditionSelection: 0,flavorSelection: 0,practiceSelection: 0,sweetSelection: 0,tea_baseSelection: 0,tea_topSelection: 0, showMore: .constant(false), showDetail: .constant(true))
    }
}
