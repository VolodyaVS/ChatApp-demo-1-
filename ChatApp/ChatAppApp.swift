//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Vladimir Stepanchikov on 22.11.2021.
//

import SwiftUI
import Firebase

@main
struct ChatAppApp: App {

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
