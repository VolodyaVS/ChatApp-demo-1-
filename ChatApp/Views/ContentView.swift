//
//  ContentView.swift
//  ChatApp
//
//  Created by Vladimir Stepanchikov on 23.11.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var sessionStore = SessionStore()

    init() {
        sessionStore.listen()
    }

    var body: some View {
        ChatList()
            .fullScreenCover(isPresented: $sessionStore.isAnon) {
                LoginView()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
