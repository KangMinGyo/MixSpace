//
//  User.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    
    @DocumentID var id: String?
    let uid: String
    let email: String
    let name: String
    let nickName: String
    let introText: String
    let profileImageURL: String
    let postNum: Int
    let follower: Int
    let following: Int
    
    var didFollow: Bool? = false
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.nickName = data["nickName"] as? String ?? ""
        self.introText = data["introText"] as? String ?? ""
        self.profileImageURL = data["profileImageURL"] as? String ?? ""
        self.postNum = data["postNum"] as? Int ?? 0
        self.follower = data["follower"] as? Int ?? 0
        self.following = data["following"] as? Int ?? 0
    }
}

