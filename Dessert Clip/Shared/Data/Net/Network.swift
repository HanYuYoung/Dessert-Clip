//
//  Network.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/3.
//

import Foundation

let baseUrl = "http://localhost:1337"

struct Network {
    static let findDrinks  = baseUrl + "/drinks"
    static let createOrder = baseUrl + "/orders"
    static let findOrders  = createOrder
    static let deleteOrder = createOrder + "/"
    static let updateOrder = createOrder + "/"
}
