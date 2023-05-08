//
//  ChatLogView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/05/01.
//

import SwiftUI

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    
    init(chatUser: ChatUser?) {
        self.chatUser = chatUser
        self.vm = .init(chatUser: chatUser)
    }
    
    @ObservedObject var vm: ChatLogViewModel
    
    var body: some View {
        messageView
        .navigationTitle(chatUser?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarItems(trailing: Button(action: {
//            vm.count += 1
//        }, label: {
//            Text("Count : \(vm.count)")
//        }))
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        ChatLogView(chatUser: ChatUser(uid: "", name: "맹고우", profileImageURL: ""))
    }
}

struct MessageView: View {
    
    let message: ChatMessage
    
    var body: some View {
        VStack {
            if message.fromID == FirebaseManager.shared.auth.currentUser?.uid {
                HStack {
                    Spacer()
                    HStack {
                        Text(message.text)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color("SpaceYellow"))
                    .cornerRadius(8)
                }
            } else {
                HStack {
                    HStack {
                        Text(message.text)
                            .foregroundColor(Color.primary)
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(8)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

extension ChatLogView {
    
    static let emptyScrollToString = "Empty"
    
    private var messageView: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    ForEach(vm.chatMesssages) { message in
                        MessageView(message: message)
                    }
                    HStack{ Spacer() }
                        .id(ChatLogView.emptyScrollToString)
                }
                .onReceive(vm.$count) { _ in
                    withAnimation(.easeOut(duration: 0.5)) {
                        scrollViewProxy.scrollTo(ChatLogView.emptyScrollToString, anchor: .bottom)
                    }
                }
            }
        }
        .background(Color("SpaceWhite"))
        .safeAreaInset(edge: .bottom) {
            chatButtonBar
                .background(Color(.systemBackground).ignoresSafeArea())
        }
    }
    
    private var chatButtonBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "message.fill")
                .font(.system(size: 24))
                .foregroundColor(Color("SpaceYellow"))
            TextField("Description", text: $vm.chatText)
            Button {
                vm.handleSend()
            } label: {
                Text("보내기")
                    .foregroundColor(Color.white)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color("SpaceYellow"))
            .cornerRadius(4)

        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}
