//
//  OrderThumbView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/7.
//

import SwiftUI
import SDWebImageSwiftUI

let r : CGFloat = 34.0

struct HalfCapsule: Shape {
    func path(in rect: CGRect) -> Path {
      
        let leftMiddle = CGPoint(x: 0, y: rect.midY)
        let rightMiddle = CGPoint(x: rect.maxX, y: rect.midY)
        let rightCorner = CGPoint(x: rect.maxX, y: 0)
        let center = CGPoint(x: rect.midX, y: rect.midY)

        return Path {
            $0.move(to: leftMiddle)
            $0.addLine(to: .zero)
            $0.addLine(to: rightCorner)
            $0.addLine(to: rightMiddle)
            
            $0.addArc(center: center, radius: r, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: true)
            
        }
    }
}

struct OrderThumbView: View {
    let imgUrl : String
    
    var body: some View {
        ZStack() {
            Circle()
                .frame(width: 2 * r)
                
                
            WebImage(url: URL(string: baseUrl + imgUrl))
                .resizable()
                .scaledToFit()
                .frame(width: 8 * r)
                .padding(.leading, 8)
        }
        .frame(width: 2 * r, height: 3 * r)
        .clipShape(HalfCapsule())
        
    }
}

struct OrderThumbView_Previews: PreviewProvider {
    static var previews: some View {
        OrderThumbView(imgUrl: drinksData[1].menus[1].imager[1].url)
            .previewLayout(.sizeThatFits)
    }
}
