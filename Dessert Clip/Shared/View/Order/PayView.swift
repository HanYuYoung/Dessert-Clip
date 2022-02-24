//
//  PayView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/11.
//

import SwiftUI
import Request

struct PayView: View {
    @State var paySelection : Int
    
    @State var loading = false
    @EnvironmentObject var store : Store
    @Binding var showPay : Bool
    @State var successPay = false
    
    func getPrice() -> Int {
        var sum = 0
        for i in 0..<store.unpaidOrders.count {
            sum = sum + store.unpaidOrders[i].price
        }
        return sum
    }
    
    func orderDescription(thisOrder: Order) -> String {
        var tar = ""
        if !(thisOrder.need_tableware_option == "") {
            tar = tar + thisOrder.need_tableware_option.replacingOccurrences(of: "（推荐）", with: "") + ","
        }
        
        if !(thisOrder.condition_option == "") {
            tar = tar + thisOrder.condition_option.replacingOccurrences(of: "（推荐）", with: "") + ", "
        }
        if !(thisOrder.flavor_option == "" || thisOrder.flavor_option == "标准（推荐）") {
            tar = tar + thisOrder.flavor_option.replacingOccurrences(of: "（推荐）", with: "") + ", "
        }
        if !(thisOrder.practice_option == "" || thisOrder.practice_option == "标准（推荐）") {
            tar = tar + thisOrder.practice_option.replacingOccurrences(of: "（推荐）", with: "") + ", "
        }
        if !(thisOrder.sweet_option == "") {
            tar = tar + thisOrder.sweet_option.replacingOccurrences(of: "（推荐）", with: "") + ", "
        }
        if !(thisOrder.tea_base_option == "") {
            tar = tar + thisOrder.tea_base_option.replacingOccurrences(of: "（推荐）", with: "") + ", "
        }
        if !(thisOrder.tea_top_option == "") {
            tar = tar + thisOrder.tea_top_option.replacingOccurrences(of: "（推荐）", with: "") + ", "
        }
        if !(thisOrder.container_option == "") {
            tar = tar + thisOrder.container_option + ", "
        }
        
        if !tar.isEmpty {
            tar.removeLast()
            tar.removeLast()
        }
        return tar
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.secondary)
                    .onTapGesture(perform: {
                        withAnimation {
                            showPay.toggle()
                        }
                    })
            }
            .padding(.top)
            .padding(.trailing)
            
            if store.pay == .single{
                VStack(alignment: .center) {
                    MenuTitle(name: store.currentOrder!.menu_name)
                    Text(orderDescription(thisOrder: store.currentOrder!))
                        .font(.system(size: 25))
                        .padding(.bottom, 22)
                        .foregroundColor(.accentColor)
                    PriceLable(price: store.discounts >= 10 ? 0: store.currentOrder!.price)
                }
                .padding()
            }else{
                VStack() {
                    ForEach(store.unpaidOrders.indices, id: \.self) { index in
                        Text("\(store.unpaidOrders[index].menu_name)")
                            .font(.system(size: 36))
                            .foregroundColor(.accentColor)
                            .frame(maxWidth: .infinity, minHeight: 70)
                        Text("\(orderDescription(thisOrder: store.unpaidOrders[index]))")
                            .font(.system(size: 25))
                            //                            .padding(.bottom, 10)
                            .foregroundColor(.accentColor)
                    }
                    PriceLable(price: getPrice())
                        .padding(.top,20)
                }
                .padding()
            }
            
            VStack(alignment: .leading) {
                Text("支付方式")
                    .font(.system(size: 24))
                    .foregroundColor(Color(.secondaryLabel))
                PayChoiceView(selection: $paySelection)
            }
            .padding()
            
            if loading {
                LoadingView()
            }
            
            if !successPay {
                Button(action: {
                    if store.pay == .single{
                        updateOrder(id: store.currentOrder!.id)
                    }else{
                        let count = store.unpaidOrders.count
                        for i in 0..<count {
                            if(i < count - 1){
                                updateOrders(index: i, id: store.unpaidOrders[i].id)
                            }else{
                                updateOrder(id: store.unpaidOrders[i].id)
                            }
                        }
                    }
                }, label: {
                    PayButton()
                })
                .padding()
            } else {
                PaidSuccessView()
            }
        }
        .background(Blur(style: .systemChromeMaterial))
        .cornerRadius(30)
        .shadow(color: .clear, radius: 2, x: 0, y: 1)
    }
    
    func updateOrders(index: Int,id: Int)  {
        var newOrder = store.unpaidOrders[index]
        newOrder.status = 1
        newOrder.payvender = paySelection.description
        
        AnyRequest<Order> {
            Url(Network.updateOrder + id.description)
            Method(.put)
            Header.ContentType(.json)
            RequestBody(newOrder)
        }
        .onObject { _ in //成功支付
            store.discounts = store.discounts + 1
        }
        .onError { error in
            print("Error update：",error)
            withAnimation {
                loading = false
            }
        }
        .call()
    }
    
    func updateOrder(id: Int)  {
        loading = true
        
        var newOrder = store.currentOrder!
        newOrder.status = 1
        newOrder.payvender = paySelection.description
        if store.pay == .single && store.discounts >= 10{
            newOrder.price = 0
        }
        
        AnyRequest<Order> {
            Url(Network.updateOrder + id.description)
            Method(.put)
            Header.ContentType(.json)
            RequestBody(newOrder)
        }
        .onObject { _ in //成功支付
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                loading.toggle()
                successPay.toggle()
            }
            
            //等成功支付动画完毕后再更新状态
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                store.action = .pay //订单支付的全局通知
                store.collapse = false //关闭侧边栏
                showPay.toggle()
                if store.pay == .single{
                    if store.discounts < 10{
                        store.discounts = store.discounts + 1
                    }else {
                        store.discounts = store.discounts % 10
                    }
                }else {
                    store.discounts = store.discounts + 1
                }
                
                UserDefaults.standard.set(self.store.discounts, forKey: "Reward")
            }
            
        }
        .onError { error in
            print("Error update：",error)
            withAnimation {
                loading = false
            }
        }
        .call()
    }
}

struct PayView_Previews: PreviewProvider {
    
    struct testView1: View {
        
        @State var sel1 : Int
        @State var showPay = false
        @StateObject var store : Store = {
            let _store = Store()
            _store.currentOrder = ordersData[0]
            _store.pay = .all
            _store.unpaidOrders = ordersData
            return _store
        }()
        
        var body: some View {
            PayView(paySelection: sel1, showPay: $showPay)
                .environmentObject(store)
        }
    }
    
    static var previews: some View {
        testView1(sel1: 0)
    }
}
