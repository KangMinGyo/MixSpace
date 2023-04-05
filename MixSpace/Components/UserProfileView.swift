//
//  UserProfileView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/05.
//

import SwiftUI
import Firebase

struct UserProfileView: View {
    
    @StateObject var vm = ProfileViewModel()
    @AppStorage("logStatus") var logStatus = false
    @State private var selectionFilter: ProfileFilterViewModel = .space
    let user: User
    
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

extension UserProfileView {
    private var HeaderView: some View {
        ZStack(alignment: .bottomLeading) {
            Color("SpaceWhite")
            
            VStack(alignment: .leading) {
                HStack {
                    Image("Profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.name)
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("@\(user.nickName)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(user.introText)
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
        }
        .padding(.horizontal)
    }
}
