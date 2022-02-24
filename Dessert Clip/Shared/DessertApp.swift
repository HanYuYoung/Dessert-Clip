//
//  DessertApp.swift
//  Shared
//
//  Created by Han Yu Young! on 2021/4/8.
//

import SwiftUI

@main
struct DessertApp: App {
    
    @StateObject var store = Store()
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(store)
//            SignInView(onshow: .constant(true))
        }
    }
}
