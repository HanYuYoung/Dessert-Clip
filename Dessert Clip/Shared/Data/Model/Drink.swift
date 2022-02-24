//
//  Drink.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/5.
//

import Foundation

struct Drink: Codable,Identifiable {
    var id = 0
    var name = ""
    var menus : [DrinkMenu] = []
}
