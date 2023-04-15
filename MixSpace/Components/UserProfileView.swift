//
//  UserProfileView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/05.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct UserProfileView: View {

    @ObservedObject var vm: UserProfileViewModel
    @AppStorage("logStatus") var logStatus = false
    @State private var selectionFilter: ProfileFilterViewModel = .post
    
    init(user: User) {
        self.vm = UserProfileViewModel(postUser: user)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            ScrollView {
                HeaderView
                
                userPostsView
                
                Spacer()
            }

        }
        
        .ignoresSafeArea()
    }
}

extension UserProfileView {
    private var HeaderView: some View {
        ZStack(alignment: .center) {
            Color("SpaceWhite")
            
            VStack(spacing: 60) {
                VStack {
                    WebImage(url: URL(string: vm.postUser.profileImageURL))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 96, height: 96)
                        .clipShape(Circle())
                    
                    VStack(alignment: .center, spacing: 4) {
                        Text(vm.postUser.name)
                            .font(.title3)
                            .foregroundColor(.gray)
                        Text("@\(vm.postUser.nickName)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(vm.postUser.introText)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onAppear(perform: vm.fetchCurrentUser)
                    
                    Button {
                        //팔로우
                    } label: {
                        Text("팔로우")
                            .font(.subheadline)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .foregroundColor(.white)
                            .background(Color("SpaceYellow"))
                            .cornerRadius(30)
                    }
                }
                .padding(.top, 100)
                
                HStack(spacing: 40) {
                    HStack(spacing: 25) {
                        VStack {
                            Text("\(vm.posts.count)")
                            Text("게시글")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                        
                        Rectangle()
                            .frame(width: 1, height: 30)
                            .foregroundColor(.gray)
                        
                        VStack {
                            Text("7")
                            Text("팔로워")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                        
                        Rectangle()
                            .frame(width: 1, height: 30)
                            .foregroundColor(.gray)
                        
                        VStack {
                            Text("10")
                            Text("팔로잉")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                    }
                }
                .padding(.top, 20)
            }
        }
        .frame(height: 600)
    }
    
    private var userPostsView: some View {
        LazyVStack {
            ForEach(vm.posts) { post in
                NewPost(post: post)
            }
        }
        .padding(.bottom, 60)
    }
}
