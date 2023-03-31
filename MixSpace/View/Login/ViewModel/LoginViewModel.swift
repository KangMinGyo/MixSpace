//
//  LoginViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/13.
//

import SwiftUI
import Foundation

import Firebase
import CryptoKit
import AuthenticationServices


class LoginViewModel: ObservableObject {
    
    @Published var nonce = ""
    @AppStorage("logStatus") var logStatus = false
    
    //Email Login
    @Published var email = ""
    @Published var password = ""
    @Published var didCompleteLoginProcess: () -> ()
    
    init(didCompleteLoginProcess: @escaping () -> Void) {
        self.didCompleteLoginProcess = didCompleteLoginProcess
    }

    // Apple Login
    func authenticate(credential: ASAuthorizationAppleIDCredential) {
        //getting token
        guard let token = credential.identityToken else {
            print("error with firebase")
            return
        }
        
        guard let tokenString = String(data: token, encoding: .utf8) else {
            print("error with token")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        Auth.auth().signIn(with: firebaseCredential) { result, err in
            if let err = err {
                print(err.localizedDescription)
            }
            
            self.storeUserInformation()
            print("로그인: \(result?.user.uid ?? "")")
            print("Loggen In Success: \(result?.user.email ?? "")")
            
            withAnimation(.easeInOut) {
                self.logStatus = true
            }
        }
    }
    
    private func storeUserInformation() {
        guard let email = FirebaseManager.shared.auth.currentUser?.email else { return }
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let name = uid.prefix(5)
        let nickname = uid.suffix(5)
        let userData = ["email": email, "uid": uid, "name": name, "nickName": nickname, "introText": "", "postNum": 0, "follower": 0, "following": 0] as [String : Any]
        FirebaseManager.shared.fireStore.collection("users") //users라는 컬렉션을 만든다
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
                print("Success")
            }
    }
    
    // Email로 로그인
    func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let err = error {
                print("Failed to login user:", err)
                return
            }
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            
            self.didCompleteLoginProcess()
            withAnimation(.easeInOut) {
                self.logStatus = true
            }
        }
    }
}

// Helper for Apple Login with Firebase
func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
    }.joined()
    
    return hashString
}

func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError(
                    "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                )
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    
    return result
}
