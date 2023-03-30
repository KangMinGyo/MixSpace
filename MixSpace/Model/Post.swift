//
//  Post.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/27.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Post: Codable, Identifiable {
    
    @DocumentID var id: String?
    let uid: String
    let text: String
    let timeStamp: Timestamp
    let imageURL: String
    let like: Int
    let comment: Int
    
    var user: User?
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp(date: Date())
        self.imageURL = data["imageURL"] as? String ?? ""
        self.like = data["like"] as? Int ?? 0
        self.comment = data["comment"] as? Int ?? 0
    }
    
    
}
