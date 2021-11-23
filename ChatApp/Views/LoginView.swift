//
//  LoginView.swift
//  ChatApp
//
//  Created by Vladimir Stepanchikov on 22.11.2021.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @ObservedObject var sessionStore = SessionStore()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button {
                    sessionStore.signIn(email: email, password: password)
                } label: {
                    Text("Sign in")
                }
                Button {
                    sessionStore.signUp(email: email, password: password)
                } label: {
                    Text("Sign up")
                }
            }
            .padding()
            .navigationTitle("Welcome")
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
