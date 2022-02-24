//
//  OrderCoverView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/11.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderCoverView: View {
    let imgUrl : String
    
    var body: some View {
        
        ZStack{
            Image("coffeeMask2")
                    .renderingMode(.template)
                    .resizable()
            .foregroundColor(Color("orderCoverMask"))
            .frame(width: 130, height: 130)
            
            WebImage(url: URL(string: baseUrl + imgUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 240)
                .offset(y: -8)
        }
    }
}


struct OrderCoverView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCoverView(imgUrl: ordersData[0].imgUrl)
    }
}
