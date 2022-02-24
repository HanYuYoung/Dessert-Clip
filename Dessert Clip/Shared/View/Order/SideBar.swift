//
//  SideBar.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/11.
//

import SwiftUI
import Request

struct SideBar: View {
    @State var collapsed = false
    @EnvironmentObject var store : Store
    @State private var selection = 0
    
    var body: some View {
        
        ZStack {
            Color("maskOverlay")
                .offset(x: collapsed ? 0 : -200)
                .opacity(collapsed ? 1 : 0)
                .animation(.easeOut)
                .transition(.opacity)
                .onTapGesture(perform: {
                    collapsed.toggle()
                })
            
            HStack(alignment: .bottom, spacing:-3) {
                ZStack(alignment: .top) {
                    LinearGradient(gradient: Gradient(colors: [Color("gradientStart"), Color("gradientEnd")]), startPoint: .leading, endPoint: .trailing)
                        .frame(width: 200, height: screen.height )
                    
                    if collapsed {
                        OrderListView(orders: $store.unpaidOrders, selection: $selection, showPay: $store.showPay)
                    }
                }
                
                ZStack {
                    Image("slide")
                        .renderingMode(.template)
                        .foregroundColor(Color("gradientEnd"))
                        .frame(width: 57)
                        .offset(y: -30)
                        .onTapGesture {
                            collapsed.toggle()
                            if !collapsed {return}
                            store.getUnpaidOrders()
                        }
                    Image(systemName: "chevron.right").font(.title).foregroundColor(.white)
                        .rotationEffect(collapsed ? .degrees(180) : .zero)
                        .offset(y: 95)
                }
                Spacer()
            }
            .offset(x: collapsed ? 0 : -200)
            .animation(.easeOut)
            .ignoresSafeArea()
            .gesture(
                DragGesture()
                    .onEnded{
                        if (abs($0.translation.width) > 10) {
                            withAnimation() {
                                collapsed.toggle()
                                if !collapsed {return}
                                store.getUnpaidOrders()
                            }
                        }
                    }
            )
            
            //支付
            if store.showPay {
                Group {
                    Color("maskOverlay")
                        .onTapGesture {
                            withAnimation {
                                store.showPay.toggle()
                            }
                        }
                    VStack {
                        Spacer()    //靠下
                        PayView(paySelection: 0, showPay: $store.showPay)
                    }.padding(.bottom, 20)
                }
                .transition(bottomUpTransition)
                .animation(.spring())
            }
        }
        .ignoresSafeArea()
        .onReceive(store.$collapse) {    //收到全局展开指令
            if $0 { //展开，获取订单
                collapsed = true
                store.getUnpaidOrders()
            } else {//关闭
                collapsed = false
            }
        }
        
    }
}

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar(collapsed: true)
            .preferredColorScheme(.dark)
            .environmentObject(Store())
    }
}
