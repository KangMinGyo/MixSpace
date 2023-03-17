//
//  ContentView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/13.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    @StateObject var loginData = LoginViewModel()
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack() {
                    Image(systemName: "moonphase.waxing.crescent")
                        .font(.system(size: 150))
                        .frame(width: 300, height: 300, alignment: .bottom)
                        .padding()
                    
                    VStack(spacing: 18) {
                        Text("당신만의 우주를 만들어보세요.")
                            .font(.system(size: 24))
                            .foregroundColor(Color("SpaceWhite"))
                        
                        VStack(spacing: 4) {
                            Text("세상에 단 하나뿐인 나만의 우주")
                                .font(.system(size: 18))
                                .foregroundColor(Color("SpaceWhite"))
                            Text("누구나 함께할 수 있는 우리들의 우주")
                                .font(.system(size: 18))
                                .foregroundColor(Color("SpaceWhite"))
                        }
                    }
                    .frame(height: 300)
                
                    SignInWithAppleButton { (request) in
                        loginData.nonce = randomNonceString()
                        request.requestedScopes = [.email, .fullName]
                        request.nonce = sha256(loginData.nonce)
                        
                    } onCompletion: { (result) in
                        switch result {
                        case .success(let user):
                            print("success")
                            guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                print("error with firebase")
                                return
                            }
                            loginData.authenticate(credential: credential)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .frame(height: 55)
                    .clipShape(Capsule())
                    .padding(.horizontal, 30)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .background(LinearGradient(
            colors: [Color("SpaceBlue"),Color("SpaceYellow")],
            startPoint: .leading,
            endPoint: .trailing
        )
            .ignoresSafeArea())
        
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            
    }
}


