//
//  ChatLogView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/05/01.
//

import SwiftUI

struct ChatLogView: View {
    
    let chatUser: ChatUser?
    @State var chatText = ""
    
    var body: some View {
        ZStack {
            messageView
            
            VStack {
                Spacer()
                chatButtonBar
                    .background(Color.white)
            }
        }
        .navigationTitle(chatUser?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatLogView_Previews: PreviewProvider {
    static var previews: some View {
        ChatLogView(chatUser: ChatUser(uid: "", name: "맹고우", profileImageURL: ""))
    }
}

extension ChatLogView {
    private var messageView: some View {
        ScrollView {
            ForEach(0..<20) { num in
                HStack {
                    Spacer()
                    HStack {
                        Text("Fack Message")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color("SpaceYellow"))
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            HStack{ Spacer() }
        }
        .background(Color("SpaceWhite"))
        .padding(.bottom, 65)
    }
    
    private var chatButtonBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "message.fill")
                .font(.system(size: 24))
                .foregroundColor(Color("SpaceYellow"))
            TextField("Description", text: $chatText)
            Button {
                
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
