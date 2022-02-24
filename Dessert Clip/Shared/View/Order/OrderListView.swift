//
//  OrderListView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/11.
//

import SwiftUI
import Request

struct OrderListView: View {
    @EnvironmentObject var status: Store
    
    @Environment(\.layoutDirection) var layout
    
    @Binding var orders : [Order]
    @Binding var selection : Int
    @Binding var showPay : Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 40,  content: {
                Image("bag")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding(.top, 30)
                if status.unpaidOrders.isEmpty{
                    Group{
                        Text("亲爱的")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("我是空的")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                        .foregroundColor(.white)
                        .font(.title)
                    .padding(.bottom, 10)
                }else{
                    if status.unpaidOrders.count > 1{
                        Button(action: {
                            showPay.toggle()
                            status.pay = .all
                            status.currentOrder = orders[status.unpaidOrders.count-1]
                        }, label: {
                            Text("合并付款")
                                .font(.system(size: 30))
                        })
                    }
                ForEach(orders.indices, id: \.self) { index in
                    LazyVStack() {
                        if orders[index].status == 0 {
                            HStack {
                                Button(action: {
                                    deleteOrder(id: orders[index].id)
                                    orders.remove(at: index)
                                }, label: {
                                    Image(systemName: "minus.circle")
                                        .font(.system(size: 25))
                                })
                                Spacer()
                            }
                            .offset(x: 15, y: 50)
                            .zIndex(1)
                        }
                        
                        OrderCoverView(imgUrl: orders[index].imgUrl)
                            .frame( width : 100)
                        
                        //未支付状态，显示支付小图标
                        if orders[index].status == 0 {
                            HStack {
                                Spacer()
                                Button(action: {
                                    showPay.toggle()
                                    status.currentOrder = orders[index]
                                    status.pay = .single
                                }, label: {
                                    Image(systemName: "creditcard.fill")
                                        .font(.system(size: 30))
                                    
                                })
                            }.offset(x: -15, y:  -40)
                        }
                        
                        Text(orders[index].menu_name)
                            .font(.system(size: 24))
                            .frame(maxWidth: 170)
                    }
                }
                }
            })
            .padding(.top, 40)
            .foregroundColor(.white)
            .frame(width: 190)
        })
    }
    
    func deleteOrder(id: Int) {
        AnyRequest<Order> {
            Url(Network.deleteOrder + id.description)
            Method(.delete)
        }
        .onObject({ _ in
            DispatchQueue.main.async {
//                debugPrint("服务器删除成功！")
                status.action = .delete
            }
        })
        .call()
    }
}

struct OrderListView_Previews: PreviewProvider {
    struct testView1: View {
        @State private var selection = 0
        @State private var orders = ordersData
        @State private var showPay = false
        
        var body: some View {
            OrderListView(orders: $orders, selection: $selection, showPay: $showPay)
        }
    }
    
    static var previews: some View {
        testView1()
            .preferredColorScheme(.dark)
    }
}
