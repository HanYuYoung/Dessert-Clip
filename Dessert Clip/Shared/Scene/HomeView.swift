//
//  HomeView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/10.
//

import SwiftUI
import Request

struct HomeView: View {
    @State var loading = false
    
    @State var drinks : [Drink] = []
    @State var drinkSelect = 0
    @State var menuSelects: [Int] = []
    
    @State var showDetail = false
    @State var showReward = false
    
    @EnvironmentObject var store : Store
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
            
            RewardsCard(totalStamps: store.discounts)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.accentColor, lineWidth: 2.5))
                .rotation3DEffect(Angle(degrees: showReward ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
                .animation(.easeInOut)
                .offset(x: showReward ? 30 : screen.width, y: -screen.height + 410)
                .onTapGesture {
                    self.showReward.toggle()
                }
                .zIndex(2)
            
            VStack {
                HStack {
                    Text("甜品")
                        .font(.system(size: 32))
                        .foregroundColor(.accentColor)
                        .offset(x: loading ? 0 : 48)
                    if drinks.isEmpty && loading {
                        LoadingView()
                    }
//                    #if APPCLIP
                    if !loading{
                        RewardButton(show: $showReward)
                            .offset(x: 150, y: 5)
                    }
//                    #endif
                }
                
                if !drinks.isEmpty {
                    DrinkListView(drinks: drinks, selection: $drinkSelect)
                    ForEach(drinks.indices) { index in
                        if drinkSelect == index {
                            Group {
                                MenuListView(menus: drinks[index].menus, selection: $menuSelects[index])
                                MenuTitleView(menu: drinks[index].menus[menuSelects[index]])
                            }
                            .onTapGesture {
                                withAnimation {
                                    showDetail.toggle()
                                    showReward = false
                                }
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 40.0)
            .padding(.leading, 10)
            
            if showDetail {
                DetailView(menu: drinks[drinkSelect].menus[menuSelects[drinkSelect]], showMore: false, showDetail: $showDetail).zIndex(3)
                    .animation(.easeInOut)
            }
            
            SideBar()
                .offset(x: drinks.isEmpty ? -100 : 0)
                .zIndex(2)
                .onAppear {
                    showReward = false
                }
            
            
            switch store.action {
            case .add:
                OrderHUD(text: "已下单，等待支付")
                    .padding(.bottom,30)
                    .padding(.trailing,30)
            case .pay:
                OrderHUD(text:"已支付,制作中！")
                    .padding(.bottom,30)
                    .padding(.trailing,30)
                
            default:
                BagButton()
                    .foregroundColor(.accentColor)
                    .padding(.bottom,50)
                    .padding(.trailing,30)
                    .offset(x: drinks.isEmpty ? 300 : 0)
                    .onTapGesture {
                        store.collapse.toggle()
                    }
            }
        }
        .onAppear {
            getDataFromNetwork()
//                                    getDataFromLocal()
        }
        
    }
    
    
    func getDataFromLocal()  {
        loading = true
        let drinks:[Drink] = drinksData
        withAnimation {
            //保存每个类别下，菜单的序号
            self.menuSelects = Array(repeating: 0, count: drinks.count)
            self.drinks = drinks
            loading = false
        }
    }
    
    func getDataFromNetwork()  {
        loading = true
        AnyRequest<[Drink]> {
            Url(Network.findDrinks)
        }
        .onObject({ drinks in
            withAnimation {
                self.menuSelects = Array(repeating: 0, count: drinks.count)
                self.drinks = drinks
                loading = false
            }
        })
        .call()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(Store())
        
    }
}
