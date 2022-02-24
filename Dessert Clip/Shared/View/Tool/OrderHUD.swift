//
//  OrderHUD.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/1/6.
//

import SwiftUI

struct OrderHUD: View {
    @State var text = ""
    @EnvironmentObject var store : Store
    
    var transition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    var body: some View {
        HStack {
            OrderThumbView(imgUrl: store.currentOrder?.imgUrl ?? "")
                .padding(5)
                .foregroundColor(Color(#colorLiteral(red: 0.2911370397, green: 0.3539694548, blue: 0.4877284765, alpha: 1)))
            Text(LocalizedStringKey(text))
                .font(.system(size: 22))
                .fontWeight(.semibold)
            
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                Image("bag")//购物袋
                    .renderingMode(.template)
                    .frame(width: 74,height: 74)
                
            }
        }
        .foregroundColor(Color("AccentColor"))
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 56)
                .foregroundColor(Color(.tertiarySystemBackground))
                .shadow(color: Color("AccentColor"), radius: 5)
                .padding(.vertical, 15)
        )//圆角矩形边框、系统背景色，带阴影（辉光）的背景，垂直方向填充
        .onAppear {//指定时间内自动消失
            let dispatchWorkHolder = DispatchWorkHolder()
            dispatchWorkHolder.work?.cancel()
            dispatchWorkHolder.work = DispatchWorkItem(block: {
                withAnimation {
                    store.action = .hudEnd
                }
            })
            //status.action != .hudEnd,
            if let work = dispatchWorkHolder.work {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: work)
            }
        }
        .transition(transition)
    }
}

class DispatchWorkHolder {
    var work: DispatchWorkItem?
}

struct testView: View {
    @State var text = ""
    @StateObject var store : Store = {
        let _status1 = Store()
        _status1.currentOrder = nil
        return _status1
    }()
    
    var body: some View {
        OrderHUD(text: text)
            .previewLayout(.sizeThatFits)
            .environmentObject(store)
    }
}

struct OrderHUD_Previews: PreviewProvider {
    static var previews: some View {
            testView(text: "已下单，等待支付")
                .previewLayout(.sizeThatFits)
    }
}
