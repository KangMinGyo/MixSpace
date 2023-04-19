//
//  ChatView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/19.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatView: View {
    @ObservedObject var vm = ChatViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                customNavBar
                messageView
                
                NavigationLink("", isActive: $vm.shouldNavigateToChatLogView) {
//                    ChatLogView(chatUser: self.chatUser)
                }
            }
            .overlay(
                newMessageButton, alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

extension ChatView {
    private var customNavBar: some View {
        HStack(spacing: 16) {
            
            WebImage(url: URL(string: vm.user?.profileImageURL ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipped()
                .cornerRadius(22)
                .shadow(radius: 5)
                .overlay(RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.gray, lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("@\(vm.user?.nickName ?? "")")
                    .font(.headline)
                HStack(spacing:4) {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 7, height: 7)
                    Text("online")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
            }
            Spacer()
        }
        .padding()
    }
    
    private var messageView: some View {
        ScrollView {
            ForEach(vm.recentMessages) { recentMessage in
                VStack{
                    Button {
//                        let uid = FirebaseManager.shared.auth.currentUser?.uid == recentMessage.fromID ? recentMessage.toID : recentMessage.fromID
//                        self.chatUser = .init(data: [FirebaseConstants.email: recentMessage.email, FirebaseConstants.profileImageURL: recentMessage.profileImageURL, FirebaseConstants.uid: uid])
                        vm.shouldNavigateToChatLogView.toggle()
                    } label: {
                        HStack(spacing: 16) {
                            WebImage(url: URL(string: recentMessage.profileImageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipped()
                                .cornerRadius(25)
                                .shadow(radius: 5)
                                .overlay(RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.gray, lineWidth: 1))
                            VStack(alignment: .leading, spacing: 8) {
                                Text(recentMessage.userName)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                Text(recentMessage.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.darkGray))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            Text(recentMessage.time)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(UIColor.systemGray))
                        }
                    }
                    Divider()
                        .padding(.vertical, 8)
                }
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 50)
    }
    
    private var newMessageButton: some View {
        Button {
            vm.shouldShowNewMessageScreen.toggle()
        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color("SpaceYellow"))
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 10)
        }
        .fullScreenCover(isPresented: $vm.shouldShowNewMessageScreen) {
            NewMessageView()
        }
    }
}
