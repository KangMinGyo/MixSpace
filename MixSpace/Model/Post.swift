//
//  Post.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/27.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Post: Identifiable {
    
    @DocumentID var id: String?
    let nickName: String
    let text: String
    let timeStamp: Timestamp
    let imageURL: String
    let like: Int
    let comment: Int
}
