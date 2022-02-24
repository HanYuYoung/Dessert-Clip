//
//  DrinkMenu.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/5.
//

import Foundation


struct DrinkMenu: Codable,Identifiable {
    var id = 0
    var name = ""
    var describe = ""
    var price = 0
    var drink = 0
    var container : [ContainerOption] = []    //分装
    var flavor : [FlavorOption] = []     //风味
    var need_tableware : [NeedTablewareOption] = []     //餐具
    var practice : [PracticeOption] = []     //做法
    var sweet : [SweetOption] = []     //甜度
    var tea_base : [TeaBaseOption] = []     //茶底
    var tea_top : [TeaTopOption] = []     //茶顶
    var condition: [ConditionOption] = []   //温度
    var imager : [CoverImage] = []     //简单图片
    var imagec : [CoverImage] = []     //复杂图片
}

struct ContainerOption:Codable,Identifiable {
    var id = 0
    var name = ""
}

struct FlavorOption:Codable,Identifiable {
    var id = 0
    var name = ""
}

struct NeedTablewareOption:Codable,Identifiable {
    var id = 0
    var name = ""
}

struct PracticeOption:Codable,Identifiable {
    var id = 0
    var name = ""
}

struct SweetOption:Codable,Identifiable {
    var id = 0
    var name = ""
}

struct TeaBaseOption:Codable,Identifiable {
    var id = 0
    var name = ""
}

struct TeaTopOption:Codable,Identifiable {
    var id = 0
    var name = ""
}

struct ConditionOption:Codable,Identifiable {
    var id = 0
    var name = ""
}

struct CoverImage: Codable,Identifiable {
    var id = 0
    var url = ""
    var formats : [String : imgDetail]
}

struct imgDetail: Codable {
    var url = ""
}
