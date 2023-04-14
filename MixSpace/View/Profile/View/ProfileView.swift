//
//  MyView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/16.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ProfileView: View {
    
    @ObservedObject var vm = ProfileViewModel()
    @AppStorage("logStatus") var logStatus = false
    @State var showProfileEditView = false
    @State private var selectionFilter: ProfileFilterViewModel = .space
    
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

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    private var HeaderView: some View {
        ZStack(alignment: .center) {
            Color("SpaceWhite")
            
            VStack(spacing: 60) {
                VStack {
                    WebImage(url: URL(string: vm.user?.profileImageURL ?? ""))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 96, height: 96)
                        .clipShape(Circle())
                    
                    VStack(alignment: .center, spacing: 4) {
                        Text(vm.user?.name ?? "이훈이")
                            .font(.title3)
                            .foregroundColor(.gray)
                        Text("@\(Text(vm.user?.nickName ?? "주먹밥러버"))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(vm.user?.introText ?? "주먹밥 먹을래?")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onAppear(perform: vm.fetchCurrentUser)
                    
                    Button {
                        showProfileEditView.toggle()
                    } label: {
                        Text("프로필 편집")
                            .font(.subheadline)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .foregroundColor(.white)
                            .background(Color("SpaceYellow"))
                            .cornerRadius(30)
                    }
                    .fullScreenCover(isPresented: $showProfileEditView) {
                        ProfileEditView()
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
        LazyVStack(pinnedViews: [.sectionHeaders]) {
            Section(header: header) {
                ForEach(vm.posts) { post in
                    NewPost(post: post)
                }
            }
        }
        .padding(.bottom, 60)
    }
    
    private var header: some View {
        VStack {
            Spacer()
            Text("내 게시물")
                .fontWeight(.bold)
                .padding(.top, 20)
            Text("\(vm.posts.count)개의 게시물")
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 100)
        .background(Rectangle().foregroundColor(.white))
    }
}
