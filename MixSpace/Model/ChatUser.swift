//
//  ChatUser.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/05/01.
//

import Foundation

struct ChatUser: Identifiable {
    var id: String { uid }
    let uid, name, profileImageURL: String
}
