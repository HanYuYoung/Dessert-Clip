//
//  Order.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/6.
//

import Foundation
import SwiftUI
import Request

struct Order: Codable, Identifiable {
    var id = 0
    var menu_id = 0
    var menu_name = ""
    var price = 0
    var quantity = 0
    var imgUrl = ""
    var status = 0     //状态
    var payvender = ""    //支付方式
    var container_option = ""    //分装
    var flavor_option = ""     //风味
    var need_tableware_option = ""     //餐具
    var practice_option = ""     //做法
    var sweet_option = ""     //甜度
    var tea_base_option = ""     //茶底
    var tea_top_option = ""     //茶顶
    var condition_option = ""   //温度
}

class Store: ObservableObject {
    enum Action: String {
        case start, add, delete, pay, hudEnd
    }
    
    enum Pay: String {
        case single, all
    }
    
    @Published var action = Action.start
    @Published var pay = Pay.single
    @Published var unpaidOrders: [Order] = []   //未付款订单
    @Published var currentOrder: Order?    //当前订单
    @Published var collapse = false    //折叠侧边栏
    @Published var showPay = false     //展示支付页面
    @Published var discounts = UserDefaults.standard.integer(forKey: "Reward")
    
    func getUnpaidOrders() {
        AnyRequest<[Order]> {
            Url(Network.findOrders)
            Query([
                "_sort"  : "created_at:DESC",
                "status" : "0",
            ])
        }
        .onObject({ orders in
            DispatchQueue.main.async {
                self.unpaidOrders = orders
            }
        })
        .call()
    }
}
