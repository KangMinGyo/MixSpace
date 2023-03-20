//
//  Managers.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/20.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    let fireStore: Firestore
    static let shared = FirebaseManager()
    
    override init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.fireStore = Firestore.firestore()
        super.init()
    }
}
