//
//  PayChoiceView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/11.
//

import SwiftUI

enum Vendor: CaseIterable {
    case alipay,wepay,applepay
    
    var desc: [String] {
        switch self {
        case .wepay:
            return ["wepay","Wechat"]
        case .alipay:
            return ["alipay","Alipay"]
        case .applepay:
            return ["applepay","Apple Pay"]
        }
    }
}

struct PayChoiceView: View {
    @Binding var selection : Int
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(alignment: .bottom) {
            
            ForEach(Vendor.allCases.indices) { index in
                VStack {
                    Image(Vendor.allCases[index].desc[0])
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width:60, height: 60)
                    
                    Text(LocalizedStringKey(Vendor.allCases[index].desc[1])).font(.system(size: 20))
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .onTapGesture {
                    selection = index
                }
                .foregroundColor(selection == index ? chooseColor(index: index) : Color("unselect"))
                
            }
            
        }.overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1.5)
                .foregroundColor(Color("unselect"))
        )
    }
    
    func chooseColor(index: Int) -> Color {
        switch index{
        case 0:
            return Color(#colorLiteral(red: 0.0682566613, green: 0.5538591146, blue: 0.9161683917, alpha: 1))
        case 1:
            return Color(#colorLiteral(red: 0.1009816453, green: 0.6763699651, blue: 0.09725800902, alpha: 1))
        default:
            return (colorScheme == .light ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        }
    }
}

struct PayChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        PayChoiceView(selection: .constant(0))
            .preferredColorScheme(.dark)
    }
}
