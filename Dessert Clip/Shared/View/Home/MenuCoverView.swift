//
//  MenuCoverView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/9.
//

import SwiftUI
import SDWebImageSwiftUI

struct MenuCoverView: View {
    let imgUrl : String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 250, height: 320)
                .foregroundColor(Color("coverMask1"))
            
            WebImage(url: URL(string: baseUrl + imgUrl))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 360)
                .padding(.bottom, 7)
        }
    }
}

struct MenuCoverView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MenuCoverView(imgUrl: drinksData[0].menus[0].imager[0].url)
                .previewLayout(.sizeThatFits)
            MenuCoverView(imgUrl: drinksData[0].menus[0].imager[0].url)
                .previewLayout(.sizeThatFits)
            MenuCoverView(imgUrl: drinksData[3].menus[1].imager[0].url)
                .previewLayout(.sizeThatFits)
        }
    }
}
