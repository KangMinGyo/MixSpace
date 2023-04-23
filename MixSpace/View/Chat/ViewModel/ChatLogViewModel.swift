//
//  ChatLogViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/19.
//

import Foundation
import Firebase

class ChatLogViewModel: ObservableObject {
    
    @Published var chatText = ""
    @Published var errorMessage = ""
    
    @Published var chatMessage = [ChatMessage]()
    @Published var emptyScrollToString = "Empty"
    
    var chatUser: User?
    
    init(chatUser: User?) {
        self.chatUser = chatUser
        
//        fetchMessages()
    }
    
    var firestoreListener: ListenerRegistration?
    
//    func fetchMessages() {
//        guard let fromID = FirebaseManager.shared.auth.currentUser?.uid else { return }
//        guard let toID = chatUser?.uid else { return }
//
//        firestoreListener = FirebaseManager.shared.fireStore
//            .collection("messages")
//            .document(fromID)
//            .collection(toID)
//            .order(by: "timeStamp")
//            .addSnapshotListener { querySnapshot, err in
//                if let err = err {
//                    self.errorMessage = "Failed to listen for messages: \(err)"
//                    print(err)
//                    return
//                }
//
//                querySnapshot?.documentChanges.forEach({ change in
//                    if change.type == .added {
//                        let data = change.document.data()
//                        self.chatMessage.append(documentID: change.document.documentID, data: data)
//                        print("Appending chatMessage in ChatLogView: \(Date())")
//                    }
//                })
//
//                DispatchQueue.main.async {
//                    self.count += 1
//                }
//            }
//    }
    
    func handleSend() {
        print(chatText)
        guard let fromID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        guard let toID = chatUser?.uid else { return }
        
        let document = FirebaseManager.shared.fireStore.collection("messages")
            .document(fromID)
            .collection(toID)
            .document()
        
        let messageData = ["fromID": fromID,
                           "toID": toID,
                           "text": self.chatText,
                           "timeStamp": Timestamp()] as [String : Any]
        
        document.setData(messageData) { err in
            if let err = err {
                self.errorMessage = "Failed to save message into Firestore: \(err)"
                return
            }
            print("Success send message")
            
            self.persistRecentMessage()
            
            self.chatText = ""
            self.count += 1
        }
        
        let recipientMessageDocument = FirebaseManager.shared.fireStore.collection("messages")
            .document(toID)
            .collection(fromID)
            .document()
        
        recipientMessageDocument.setData(messageData) { err in
            if let err = err {
                print(err)
                self.errorMessage = "Failed to save message into Firestore: \(err)"
                return
            }
            print("Success saved message")
        }
    }
    
    private func persistRecentMessage() {
        guard let chatUser = chatUser else { return }
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toID = self.chatUser?.uid else { return }
        
        let document = FirebaseManager.shared.fireStore
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .document(toID)
        
        let data = ["timestamp": Timestamp(),
                    "text": self.chatText,
                    "fromID": uid,
                    "toID": toID,
                    "profileImageURL": chatUser.profileImageURL,
                    "nickName": chatUser.nickName] as [String : Any]
        
        
        
        document.setData(data) { err in
            if let err = err {
                self.errorMessage = "Failed to save recent message: \(err)"
                print("Failed to save recent message: \(err)")
                return
            }
        }
        
    }
    @Published var count = 0
}

