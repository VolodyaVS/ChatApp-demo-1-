//
//  Message.swift
//  ChatApp
//
//  Created by Vladimir Stepanchikov on 24.11.2021.
//

import Foundation

struct Message: Identifiable, Codable {
    let id: String?
    let content: String
    let name: String
}
