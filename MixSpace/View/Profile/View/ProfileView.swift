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
    
    @StateObject var vm = ProfileViewModel()
    @AppStorage("logStatus") var logStatus = false
    @State var showProfileEditView = false
    @State private var selectionFilter: ProfileFilterViewModel = .space
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HeaderView
            
            infoView

            //            filterBar
            
            //            gridView
            
            Spacer()
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
        ZStack(alignment: .bottomLeading) {
            Color("SpaceWhite")
            
            VStack(alignment: .leading) {
                HStack {
                    WebImage(url: URL(string: vm.user?.profileImageURL ?? ""))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(vm.user?.name ?? "")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("@\(Text(vm.user?.nickName ?? ""))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(vm.user?.introText ?? "")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                    }
                    .onAppear(perform: vm.fetchCurrentUser)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .frame(height: 300)
    }
    
    private var infoView: some View {
        HStack() {
            HStack(spacing: 30) {
                VStack {
                    Text("21")
                    Text("게시글")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                
                VStack {
                    Text("7")
                    Text("팔로워")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                
                VStack {
                    Text("10")
                    Text("팔로잉")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
            }
            
            Spacer()
            
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
        .padding(.horizontal)
    }
}
