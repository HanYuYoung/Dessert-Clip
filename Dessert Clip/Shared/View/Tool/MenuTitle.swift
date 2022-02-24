//
//  MenuTitle.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/10.
//

import SwiftUI

struct MenuTitle: View {
    var name = ""

    var body: some View {
        Text(name)
            .font(.system(size: 36))
            .foregroundColor(.accentColor)
            .lineLimit(2) //文字两行显示
            .frame(maxWidth: .infinity,minHeight: 125)
    }
}

struct MenuTitle_Previews: PreviewProvider {
    static var previews: some View {
        MenuTitle(name: "芝芝莓莓🍓")
    }
}
