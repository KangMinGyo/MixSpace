//
//  RecentMessage.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/05/02.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct RecentMessage: Codable, Identifiable {
    
    @DocumentID var id: String?
    
    let text, fromID, toID: String
    let name, profileImageURL: String
    let timestamp: Date
    
    var time: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
