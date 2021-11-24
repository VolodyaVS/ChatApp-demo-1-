//
//  JoinView.swift
//  ChatApp
//
//  Created by Vladimir Stepanchikov on 24.11.2021.
//

import SwiftUI

struct JoinView: View {
    @State var joinCode = ""
    @State var newTitle = ""

    @ObservedObject var viewModel = ChatroomViewModel()
    @Binding var isOpen: Bool

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Join a chatroom")
                        .font(.title)
                    TextField("Enter your join code", text: $joinCode)
                    Button {
                        viewModel.joinChatroom(code: joinCode) {
                            isOpen = false
                        }
                    } label: {
                        Text("Join")
                    }
                }.padding()
                VStack {
                    Text("Create a chatroom")
                        .font(.title)
                    TextField("Enter your title chatroom", text: $newTitle)
                    Button {
                        viewModel.createChatroom(title: newTitle) {
                            isOpen = false
                        }
                    } label: {
                        Text("Create")
                    }
                }.padding()
            }
            .navigationTitle("Join or create")
        }
    }
}

struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView(isOpen: .constant(true))
    }
}
