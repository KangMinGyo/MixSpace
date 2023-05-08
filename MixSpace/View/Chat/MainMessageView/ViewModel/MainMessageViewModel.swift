//
//  MainMessageViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/29.
//

import Foundation
import Firebase

class MainMessageViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    
    @Published var shouldShowNewMessageScreen = false
    @Published var shouldNavigateToChatLogView = false
    
    let service = UserService()
    
    init() {
        fetchCurrentUser()
        
        fetchRecentMessages()
    }
    
    @Published var recentMessages = [RecentMessage]()
    
    private var firestoreListener: ListenerRegistration?
    
    private func fetchRecentMessages() {
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
                    self.errorMessage = "Failed to listen for recent messages: \(err)"
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
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "파베에 uid가 없어잉"
            return
        }
        
        FirebaseManager.shared.fireStore.collection("users").document(uid)
            .getDocument { snapshot, err in
                if let err = err {
                    print("Failed to fetch current user:", err)
                    return
                }
                
                guard let data = snapshot?.data() else { return }
                
                let uid = data["uid"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let profileImageURL = data["profileImageURL"] as? String ?? ""
                self.chatUser = ChatUser(uid: uid, name: name, profileImageURL: profileImageURL)

        }
    }
}
