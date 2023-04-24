//
//  ChatMessage.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/19.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ChatMessage: Identifiable {
    
    var id: String { documentID }
    let documentID: String
    let fromID: String
    let toID: String
    let text: String
    let email: String
    let timestamp: Date
    let profileImageURL: String
    
    var time: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
