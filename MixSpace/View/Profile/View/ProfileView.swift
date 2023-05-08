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
    @State var showFollowingList = false
    @State var showFollowerList = false
    @State private var selectionFilter: ProfileFilterViewModel = .post
    
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
                        
                        Button {
                            showFollowerList.toggle()
                        } label: {
                            VStack {
                                Text("\(vm.user?.follower ?? 0)")
                                    .foregroundColor(.black)
                                Text("팔로워")
                                    .foregroundColor(.gray)
                                    .font(.headline)
                            }
                            .sheet(isPresented: $showFollowerList) {
                                FollowerView()
                            }
                        }
                        
                        Rectangle()
                            .frame(width: 1, height: 30)
                            .foregroundColor(.gray)
                        
                        Button {
                            showFollowingList.toggle()
                        } label: {
                            VStack {
                                Text("\(vm.user?.following ?? 0)")
                                    .foregroundColor(.black)
                                Text("팔로잉")
                                    .foregroundColor(.gray)
                                    .font(.headline)
                            }
                            .sheet(isPresented: $showFollowingList) {
                                FriendListView()
                            }
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
            Section(header: filterBar) {
                ForEach(vm.posts(forFilter: self.selectionFilter)) { post in
                    NewPost(post: post)
                }
            }
        }
        .padding(.bottom, 60)
    }
    
    private var filterBar: some View {
        HStack {
            ForEach(ProfileFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text("\(item.title)")
                        .font(.subheadline)
                        .fontWeight(selectionFilter == item ? .semibold : .regular)
                        .foregroundColor(selectionFilter == item ? .primary : .gray)
                    
                    if selectionFilter == item {
                        Rectangle()
                            .foregroundColor(Color("SpaceYellow"))
                            .frame(height: 3)
                    } else {
                        Rectangle()
                            .foregroundColor(Color("SpaceWhite"))
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectionFilter = item
                    }
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 150)
        .background(Rectangle().foregroundColor(.white))
    }
}
