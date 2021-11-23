//
//  ChatroomViewModel.swift
//  ChatApp
//
//  Created by Vladimir Stepanchikov on 23.11.2021.
//

import Foundation
import Firebase

class ChatroomViewModel: ObservableObject {
    @Published var chatromms = [Chatroom]()

    private let database = Firestore.firestore()
    private let user = Auth.auth().currentUser

    func fetchData() {
        if user != nil {
            database.collection("chatrooms")
                .whereField("users", arrayContains: user!.uid)
                .addSnapshotListener { snapshot, error in
                    guard let documents = snapshot?.documents else {
                        print("No documents")
                        return
                    }
                    self.chatromms = documents.map({ docSnapshot -> Chatroom in
                        let data = docSnapshot.data()
                        let docId = docSnapshot.documentID
                        let title = data["title"] as? String ?? ""
                        let joinCode = data["joinCode"] as? Int ?? -1
                        return Chatroom(id: docId, title: title, joinCode: joinCode)
                    })
                }
        }
    }
}
