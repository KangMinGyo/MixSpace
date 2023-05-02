//
//  ChatLogViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/05/02.
//

import Foundation
import Firebase

struct ChatMessage: Identifiable {
    
    var id: String { documentId }
    
    let documentId: String
    let fromID, toID, text: String
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromID = data["fromID"] as? String ?? ""
        self.toID = data["toID"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
    }
}

class ChatLogViewModel: ObservableObject {
    
    @Published var chatText = ""
    @Published var chatMesssages = [ChatMessage]()
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser? ) {
        self.chatUser = chatUser
        
        fetchMessages()
    }
    
    func fetchMessages() {
        guard let fromID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let toID = chatUser?.uid else { return }
        
        FirebaseManager.shared.fireStore
            .collection("messages")
            .document(fromID)
            .collection(toID)
            .order(by: "timeStamp") //시간 순서대로 
            .addSnapshotListener { querySnapshot, err in
                if let err = err {
                    print(err)
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        self.chatMesssages.append(.init(documentId: change.document.documentID, data: data))
                    }
                })
                
                //이렇게 하면 메시지 보내면 전 메시지와 함께 중복으로 fetch됨
//                querySnapshot?.documents.forEach({ queryDocumentSnapshot in
//                    let data = queryDocumentSnapshot.data()
//                    let docId = queryDocumentSnapshot.documentID
//                    self.chatMesssages.append(.init(documentId: docId, data: data))
//                })
            }
    }
    
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
                return
            }
            print("메시지 보내기 성공")
            self.chatText = ""
        }
        let recipientMessageDocument = FirebaseManager.shared.fireStore.collection("messages")
            .document(toID)
            .collection(fromID)
            .document()
        
        recipientMessageDocument.setData(messageData) { err in
            if let err = err {
                print(err)
                return
            }
            print("메시지 받기 성공")
        }
    }
}
