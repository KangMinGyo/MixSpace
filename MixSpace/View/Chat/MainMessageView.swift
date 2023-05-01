//
//  MainMessageView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/27.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatUser: Identifiable {
    var id: String { uid } 
    let uid, name, profileImageURL: String
}

struct MainMessageView: View {
    @ObservedObject private var vm = MainMessageViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                customNavigationBar
            
                messageView
                
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
            ForEach(0..<10, id: \.self) { num in
                VStack {
                    HStack(spacing: 16) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 32))
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 44)
                                .stroke(Color.gray, lineWidth: 0.5))
                        
                        VStack(alignment: .leading) {
                            Text("UserName")
                                .font(.system(size: 16, weight: .bold))
                            Text("Message sent to user")
                                .font(.system(size: 14))
                                .foregroundColor(Color(.lightGray))
                        }
                        Spacer()
                        
                        Text("22d")
                            .font(.system(size: 14, weight: .semibold))
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
            NewMessageView()
        }
    }
}
