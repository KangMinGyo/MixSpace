//
//  SignUpView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/31.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm = SignUpViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    emailView
                    
                    Button {
                        vm.handleAction()
                        dismiss()
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
            .navigationTitle("회원가입")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

extension SignUpView {
    private var emailView: some View {
        VStack(alignment: .leading) {
            Text("이메일")
                .font(.headline)
                .foregroundColor(.primary)
            TextArea(placeholder: "ex) space2023@space.com", text: $vm.email)
                .keyboardType(.emailAddress)
                .onTapGesture {
                    self.hideKeyboard()
                }
            Divider()
                .frame(height: 1)
            
            Text("비밀번호")
                .font(.headline)
                .foregroundColor(.primary)
            TextArea(placeholder: "password", text: $vm.password)
                .onTapGesture {
                    self.hideKeyboard()
                }
            Divider()
                .frame(height: 1)
            
        }.padding()
    }
}
