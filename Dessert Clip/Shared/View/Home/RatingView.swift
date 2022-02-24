//
//  RatingView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/8.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self){ num in
                Image(systemName: "star.fill")
                    .foregroundColor(num > self.rating ? .gray : .yellow)
                    .onTapGesture {
                        self.rating = num
                }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
    }
}

