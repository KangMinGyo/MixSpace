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
    
    @DocumentID var id: String?
    let documentID: String
    let fromID: String
    let toID: String
    let text: String
    let email: String
    let timestamp: Timestamp
    let profileImageURL: String

}
