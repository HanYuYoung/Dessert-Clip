//
//   RewardsCard.swift
//  Fruta
//
//  Created by Han Yu Young! on 2021/2/13.
//  Copyright © 2021 Apple. All rights reserved.
//

import SwiftUI

struct RewardsCard: View {
    var totalStamps: Int
  
    var columns: [GridItem] {
        [GridItem](repeating: GridItem(.flexible(minimum: 20), spacing: 10), count: 5)
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text("积分卡")
                    .font(.system(size: 35))
                    .padding(.top, 10)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(1...10, id: \.self) { index in
                        
                        if index <= totalStamps {
                            StampSlot(status: true)
                        }
                        else {
                            StampSlot(status: false)
                        }
                    }
                }
                .frame(width: 280)
                .padding(20)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .accessibility(label: Text("\(totalStamps) of 10 points earned"))
            
            Text(totalStamps < 10 ? "再下单 \(10 - totalStamps) 次可以获得一份免费甜品!"
                    : "祝贺🎉，可得到一份免费甜品🍰!")
                .font(Font.system(.title3, design: .rounded).bold())
                .multilineTextAlignment(.center)
                .foregroundColor(Color("rewards"))
                .padding([.horizontal], 20)
            
        }
        .padding(28)
        .background(colorScheme == .light ? Color("currency") : Color(#colorLiteral(red: 0.185514871, green: 0.2300924586, blue: 0.3179600748, alpha: 1)))
    }
}

struct RewardsCard_Previews: PreviewProvider {
    static var previews: some View {
        RewardsCard(totalStamps: 8)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
