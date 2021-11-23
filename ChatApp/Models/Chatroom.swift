//
//  Chatroom.swift
//  ChatApp
//
//  Created by Vladimir Stepanchikov on 23.11.2021.
//

import Foundation

struct Chatroom: Codable, Identifiable {
    let id: String
    let title: String
    let joinCode: Int
}
