//
//  ContainerOptionsView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/11.
//


import SwiftUI

struct ContainerOptionsView: View {
    @Binding var selection : Int
    var options : [ContainerOption]
    
    var body: some View {
        
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        
            ZStack(alignment: .topLeading) {
                ForEach(0..<options.count,id: \.self) { index in
                    Text(options[index].name)
                        .font(.system(size: 20))
                        .foregroundColor(selection == index ? Color.accentColor : Color("unselect"))
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 3)
                                .foregroundColor(selection == index ? Color.black : Color("unselect"))
                                .background(selection == index ? Color.accentColor : Color("unselect"))
                                .cornerRadius(10)
                                .opacity(selection == index ? 0.15 : 0.08)
                        )
                        .padding(.all,5)
                        .padding(.horizontal,5)
                        .cornerRadius(5)
                        .alignmentGuide(.leading, computeValue: { d in
                            if (abs(width - d.width) > screen.size.width)
                            {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if index == self.options.count-1 {
                                width = 0 //last item
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: {d in
                            let result = height
                            if index == self.options.count-1 {
                                height = 0 // last item
                            }
                            return result
                        })
                        .onTapGesture {
                            selection = index
                        }
                }
            
        }
    }
}


struct ContainerOptionsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContainerOptionsView(selection: .constant(0), options: drinksData[4].menus[0].container)
    }
}

