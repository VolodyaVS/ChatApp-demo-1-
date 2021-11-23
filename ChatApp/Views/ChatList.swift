//
//  ChatList.swift
//  ChatApp
//
//  Created by Vladimir Stepanchikov on 23.11.2021.
//

import SwiftUI

struct ChatList: View {
    @ObservedObject var viewModel = ChatroomViewModel()
    
    init() {
        viewModel.fetchData()
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.chatromms) { chatroom in
                Text(chatroom.title)
                Spacer()
            }
            .navigationTitle("Chatrooms")
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
