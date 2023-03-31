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
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack() {
                    Image(systemName: "moon.fill")
                        .foregroundColor(Color("moon"))
                        .font(.system(size: 150))
                        .frame(width: 200, height: 200, alignment: .bottom)
                        .padding()
                    
                    VStack() {
                        
                        loginView
                        
                        loginButton
                        
                        appleLogin

                    }
                    
                }
                .frame(maxWidth: .infinity)
            }
        }
//        .background(LinearGradient(
//            colors: [Color("SpaceBlue"),Color("SpaceYellow")],
//            startPoint: .leading,
//            endPoint: .trailing
//        )
        
//            .ignoresSafeArea())
        
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            
    }
}

extension LoginView {
    private var appleLogin: some View {
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
    
    private var loginView: some View {
        VStack(alignment: .leading) {
            Text("이메일")
                .font(.headline)
                .foregroundColor(.primary)
            LoginArea(placeholder: "ex) space2023@space.com", text: $email)
                .onTapGesture {
                    self.hideKeyboard()
                }
            Divider()
                .frame(height: 1)
            
            Text("비밀번호")
                .font(.headline)
                .foregroundColor(.primary)
            LoginArea(placeholder: "password", text: $password)
                .onTapGesture {
                    self.hideKeyboard()
                }
            Divider()
                .frame(height: 1)
            
        }.padding()
    }
    
    private var loginButton: some View {
        VStack(spacing: 10) {
            Button {
                
            } label: {
                HStack {
                    Spacer()
                    Text("로그인")
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .font(.system(size: 14, weight: .semibold))
                    Spacer()
                }
                .background(Color.black)
                .clipShape(Capsule())
                .padding(.horizontal, 30)
            }
            
            Button {
                
            } label: {
                HStack {
                    Spacer()
                    Text("회원가입")
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .font(.system(size: 14, weight: .semibold))
                    Spacer()
                }
                .background(Color.black)
                .clipShape(Capsule())
                .padding(.horizontal, 30)
            }

        }
    }
}

//VStack(spacing: 18) {
//    Text("당신만의 우주를 만들어보세요.")
//        .font(.system(size: 24))
//        .foregroundColor(Color("SpaceWhite"))
//
//    VStack(spacing: 4) {
//        Text("세상에 단 하나뿐인 나만의 우주")
//            .font(.system(size: 18))
//            .foregroundColor(Color("SpaceWhite"))
//        Text("누구나 함께할 수 있는 우리들의 우주")
//            .font(.system(size: 18))
//            .foregroundColor(Color("SpaceWhite"))
//    }
//}
//.frame(height: 300)
