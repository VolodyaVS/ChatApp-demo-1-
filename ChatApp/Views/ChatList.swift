//
//  ChatList.swift
//  ChatApp
//
//  Created by Vladimir Stepanchikov on 23.11.2021.
//

import SwiftUI

struct ChatList: View {
    @ObservedObject var viewModel = ChatroomViewModel()
    @State var joinModal = false

    init() {
        viewModel.fetchData()
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.chatromms) { chatroom in
                NavigationLink(destination: MessageView(chatroom: chatroom)) {
                    HStack {
                        Text(chatroom.title)
                        Spacer()
                    }
                }
                .navigationTitle("Chatrooms")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            joinModal = true
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
                .sheet(isPresented: $joinModal) {
                    JoinView(isOpen: $joinModal)
                }
            }
            .listStyle(.plain)
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
