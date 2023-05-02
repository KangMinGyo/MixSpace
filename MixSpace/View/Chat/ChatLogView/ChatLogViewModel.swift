//
//  ChatLogViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/05/02.
//

import Foundation
import Firebase

class ChatLogViewModel: ObservableObject {
    
    @Published var chatText = ""
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser? ) {
        self.chatUser = chatUser
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
