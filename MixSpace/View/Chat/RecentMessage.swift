//
//  RecentMessage.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/19.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct RecentMessage: Codable, Identifiable {
    
    @DocumentID var id: String?
    let text: String
    let fromID, toID: String
    let email, profileImageURL: String
    let timestamp: Date
    
    var userName: String {
        email.components(separatedBy: "@").first ?? email
    }
    
    var time: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
