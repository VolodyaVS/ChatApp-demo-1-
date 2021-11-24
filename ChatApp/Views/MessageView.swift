//
//  MessageView.swift
//  ChatApp
//
//  Created by Vladimir Stepanchikov on 24.11.2021.
//

import SwiftUI

struct MessageView: View {
    let chatroom: Chatroom
    @ObservedObject var viewModel = MessageViewModel()
    @State var message = ""

    init(chatroom: Chatroom) {
        self.chatroom = chatroom
        viewModel.fetchData(docId: chatroom.id)
    }
    
    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                HStack {
                    Text(message.content)
                    Spacer()
                }
            }
            HStack {
                TextField("Enter message", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    viewModel.sendMessage(messageContent: message, docId: chatroom.id)
                } label: {
                    Text("Send")
                }

            }.padding()
        }
        .navigationTitle(chatroom.title)
        .listStyle(.plain)
    }
}
