//
//  Dessert_ClipApp.swift
//  Dessert Clip
//
//  Created by Han Yu Young! on 2021/4/8.
//

import SwiftUI

@main
struct Dessert_ClipApp: App {
    @StateObject var store = Store()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
