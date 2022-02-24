//
//  BagButton.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/11.
//

import SwiftUI

struct BagButton: View {
        @EnvironmentObject var store : Store
        
        var body: some View {
            
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                Image("bag")
                    .renderingMode(.template)
                    .frame(width: 74,height: 74)
                    .overlay(
                        RoundedRectangle(cornerRadius: 37)
                            .stroke(lineWidth: 3)
                    )
                
                if store.unpaidOrders.count > 0 {//数字角标
                    ZStack {
                        Circle()
                            .frame(width: 25, height: 25)
                        Text(store.unpaidOrders.count < 100 ? "\(store.unpaidOrders.count)" : "99+")
                            .foregroundColor(Color(.systemBackground))
                    }.offset(x: -8, y: 8)
                }
            }
            //hub结束并不获取新订单
            .onReceive(store.$action) { index in
                if index != .hudEnd {
                    store.getUnpaidOrders()
                }
            
        }
    }
}

struct BagButton_Previews: PreviewProvider {
    static var previews: some View {
        BagButton()
            .previewLayout(.sizeThatFits)
            .environmentObject(Store())
    }
}
