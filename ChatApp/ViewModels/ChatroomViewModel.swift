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

    func createChatroom(title: String, handler: @escaping () -> Void) {
        if user != nil {
            database.collection("chatrooms")
                .addDocument(data: [
                    "title": title,
                    "joinCode": Int.random(in: 10000..<99999),
                    "users": [user!.uid]]) { error in
                        if let error = error {
                            print("Error adding document: \(error)")
                        } else {
                            handler()
                        }
                    }
        }
    }

    func joinChatroom(code: String, handler: @escaping () -> Void) {
        if user != nil {
            database.collection("chatrooms")
                .whereField("joinCode", isEqualTo: Int(code))
                .getDocuments() { snapshot, error in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        for document in snapshot!.documents {
                            self.database.collection("chatrooms")
                                .document(document.documentID)
                                .updateData(["users": FieldValue.arrayUnion([self.user!.uid])])
                            handler()
                        }
                    }
                }
        }
    }
}
