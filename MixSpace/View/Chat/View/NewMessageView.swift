//
//  NewMessageView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/19.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewMessageView: View {
    @ObservedObject var vm = NewMessageViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                userProfiles
            }
            .navigationTitle("새로운 메시지")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView()
    }
}

extension NewMessageView {
    
    private var userProfiles: some View {
        ForEach(vm.users) { user in
            Button {
                dismiss()
//                viewModel.didSelectNewUser(user)
            } label: {
                HStack(spacing: 16){
                    WebImage(url: URL(string: user.profileImageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                        .clipped()
                        .cornerRadius(22)
                        .overlay(RoundedRectangle(cornerRadius: 22)
                            .stroke(Color.gray, lineWidth: 1))
                    Text("@\(user.nickName)")
                        .foregroundColor(.black)
                    Spacer()
                }.padding(.horizontal)
                Divider()
            }
        }
    }
}
