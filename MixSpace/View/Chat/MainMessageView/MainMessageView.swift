//
//  MainMessageView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/27.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainMessageView: View {
    @ObservedObject private var vm = MainMessageViewModel()
    @State var chatUser: ChatUser?
    @State var shouldNavigateToChatLogView = false
    
    var body: some View {
        NavigationView {
            VStack {
                customNavigationBar
                messageView
                
                NavigationLink("", isActive: $shouldNavigateToChatLogView) {
                    ChatLogView(chatUser: self.chatUser)
                }
                
            }.overlay(
                newMessageButton, alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
}

struct MainMessageView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessageView()
    }
}

extension MainMessageView {
    private var customNavigationBar: some View {
        HStack(spacing: 16) {
            
            WebImage(url: URL(string: vm.chatUser?.profileImageURL ?? ""))
//            Image(systemName: "person.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
                .overlay(RoundedRectangle(cornerRadius: 44)
                    .stroke(Color.gray, lineWidth: 0.5))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(vm.chatUser?.name ?? "")")
                    .font(.system(size: 24, weight: .bold))
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
            Image(systemName: "gear")
        }.padding()
    }
    
    private var messageView: some View {
        ScrollView {
            ForEach(vm.recentMessages) { recentMessage in
                VStack {
                    Button {
                        let uid = FirebaseManager.shared.auth.currentUser?.uid == recentMessage.fromID ? recentMessage.toID : recentMessage.fromID
                        self.chatUser = .init(uid: uid, name: recentMessage.name, profileImageURL: recentMessage.profileImageURL)
                        self.shouldNavigateToChatLogView.toggle()
                    } label: {
                        HStack(spacing: 16) {
                            WebImage(url: URL(string: recentMessage.profileImageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                                .overlay(RoundedRectangle(cornerRadius: 44)
                                    .stroke(Color.gray, lineWidth: 0.5))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(recentMessage.name)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(Color.primary)
                                Text(recentMessage.text)
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(.lightGray))
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            
                            Text(recentMessage.time)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(.lightGray))
                        }
                    }
                }
                Divider()
                    .padding(.vertical, 8)
            }.padding(.horizontal)
        }.padding(.bottom, 50)
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
            .padding()
            .shadow(radius: 10)
        }
        .fullScreenCover(isPresented: $vm.shouldShowNewMessageScreen) {
            NewMessageView(didSelectNewUser: { user in
                print(user.name)
                self.shouldNavigateToChatLogView.toggle()
                self.chatUser = user
            })
        }
    }
}
