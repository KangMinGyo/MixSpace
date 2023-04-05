//
//  SignUpViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/31.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var nickName = ""
    
    func handleAction() {
        creatNewAccount()
    }
    
    func creatNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if let err = error {
                print("Failed to cerate user:", err)
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
            
            self.storeUserInformation()
        }
    }
    
    private func storeUserInformation() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["email": email,
                        "uid": uid,
                        "name": name,
                        "nickName": nickName,
                        "introText": "",
                        "profileImageURL": "",
                        "postNum": 0,
                        "follower": 0,
                        "following": 0] as [String : Any]
        
        FirebaseManager.shared.fireStore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
                print("Success")
                
            }
        }
}
