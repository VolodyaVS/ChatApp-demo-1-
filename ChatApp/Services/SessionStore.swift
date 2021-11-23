//
//  SessionStore.swift
//  ChatApp
//
//  Created by Vladimir Stepanchikov on 23.11.2021.
//

import Foundation
import FirebaseAuth

class SessionStore: ObservableObject {
    @Published var session: User?
    @Published var isAnon = false

    var handle: AuthStateDidChangeListenerHandle?
    let authRef = Auth.auth()

    func listen() {
        handle = authRef.addStateDidChangeListener({ auth, user in
            if let user = user {
                self.isAnon = false
                self.session = User(id: user.uid, email: user.email!)
            } else {
                self.isAnon = true
                self.session = nil
            }
        })
    }

    func signIn(email: String, password: String) {
        authRef.signIn(withEmail: email, password: password)
    }

    func signUp(email: String, password: String) {
        authRef.createUser(withEmail: email, password: password)
    }

    func signOut() -> Bool {
        do {
            try authRef.signOut()
            self.isAnon = true
            self.session = nil
            return true
        } catch {
            return false
        }
    }

    func unbind() {
        if let handle = handle {
            authRef.removeStateDidChangeListener(handle)
        }
    }
}
