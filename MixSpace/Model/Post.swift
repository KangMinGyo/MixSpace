//
//  Post.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/27.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI

struct Post: Codable, Identifiable, Hashable {
    
    @DocumentID var id: String?
    let uid: String
    let text: String
    let timeStamp: Date
    let imageURL: String
    let like: Int
    let comment: Int
    
    var user: User?
    var didLike: Bool? = false
    
    var time: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: timeStamp, relativeTo: Date())
    }
                      
}
