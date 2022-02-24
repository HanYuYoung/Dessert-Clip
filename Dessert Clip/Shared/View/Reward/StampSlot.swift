//
//  StampSlot.swift
//  Dessert
//
//  Created by Han Yu Young! on 2021/3/9.
//

import SwiftUI

struct StampSlot: View {
        var status: Bool
        
        var body: some View {
            ZStack {
                Circle()
                    .fill(Color("bubbles").opacity(0.5))
                Image(systemName: "seal.fill")
                    .font(.system(size: 28))
                    .scaleEffect(1)
                    .opacity(status ? 1 : 0)
                    .foregroundColor(Color("rewards"))
            }
            .aspectRatio(1, contentMode: .fit)
        }
    
}

struct StampSlot_Previews: PreviewProvider {
    static var previews: some View {
        StampSlot(status: true)
    }
}
