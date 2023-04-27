//
//  ChatViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/19.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class ChatViewModel: ObservableObject {
    let service = UserService()
    
    @Published var user: User?
    @Published var chatUsers = [User]()
    @Published var recentMessages = [RecentMessage]()
    
    @Published var shouldShowLogOutOptions = false
    @Published var shouldShowNewMessageScreen = false
    @Published var shouldNavigateToChatLogView = false

    init() {
        fetchCurrentUser()
        fetchRecentMessages()
    }

    private var firestoreListener: ListenerRegistration?
    
    func fetchRecentMessages() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        firestoreListener?.remove()
        self.recentMessages.removeAll()
        
        firestoreListener = FirebaseManager.shared.fireStore
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, err in
                if let err = err {
                    print(err)
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    let docID = change.document.documentID
                    
                    if let index = self.recentMessages.firstIndex(where: { rm in
                        return rm.id == docID
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    
                    do {
                        let rm = try change.document.data(as: RecentMessage.self)
                        self.recentMessages.insert(rm, at: 0)
                    } catch {
                        print(error)
                    }
                })
            }
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        service.fetchCurrentUser(uid: uid) { user in
            self.user = user
        }
    }
}
