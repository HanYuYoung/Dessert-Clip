//
//  SignInView.swift
//  Dessert (iOS)
//
//  Created by Han Yu Young! on 2021/2/7.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @Binding var onshow : Bool
    
    var body: some View {
        VStack{
            SignInWithAppleButton(
                .signIn,
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success (_):
                        self.onshow.toggle()
                    case .failure (let error):
                        print("rhe01 Authorization failed: " + error.localizedDescription)
                    }
                }
            )
            .signInWithAppleButtonStyle(.black)
            .foregroundColor(.black)
            .frame(width: 300,height: 80)
            .cornerRadius(20)
            Button(action: {
                onshow.toggle()
            }, label: {
                Text("Button")
            })
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(onshow: .constant(true))
    }
}
