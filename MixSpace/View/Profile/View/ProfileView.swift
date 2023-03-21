//
//  MyView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/16.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    
    @StateObject var vm = ProfileViewModel()
    @AppStorage("logStatus") var logStatus = false
    @State private var selectionFilter: ProfileFilterViewModel = .space
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    let imageDimension = UIScreen.main.bounds.width / 3
    
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
                    Image("Profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        //                    Text(vm.user?.email ?? "")
                        Text("이훈이")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("@ 주먹밥러버")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("주먹밥머리 훈이예용")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                    }
                    
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
                    Text("팔로우")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                
                VStack {
                    Text("10")
                    Text("팔로워")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
            }

            Spacer()
            
            NavigationLink {
                ProfileEditView()
            } label: {
                Text("프로필 편집")
                    .font(.subheadline)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .background(Color("SpaceYellow"))
                    .cornerRadius(30)
            }
        }
        .padding(.horizontal)
    }
    
//    private var filterBar: some View {
//        HStack {
//            ForEach(ProfileFilterViewModel.allCases, id: \.rawValue) { item in
//                VStack {
//                    Text("\(item.title)")
//                        .font(.subheadline)
//                        .fontWeight(selectionFilter == item ? .semibold : .regular)
//                        .foregroundColor(selectionFilter == item ? .primary : .gray)
//
//                    if selectionFilter == item {
//                        Rectangle()
//                            .foregroundColor(Color("SpaceYellow"))
//                            .frame(height: 3)
//                    } else {
//                        Rectangle()
//                            .foregroundColor(Color("SpaceWhite"))
//                            .frame(height: 3)
//                    }
//                }
//                .onTapGesture {
//                    withAnimation(.easeInOut) {
//                        self.selectionFilter = item
//                    }
//                }
//            }
//        }
//    }
    
//    private var gridView: some View {
//        ScrollView {
//            LazyVGrid(columns: columns, spacing: 2) {
//                ForEach(0...4, id: \.self) { index in
//                    Image("TestImage")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: imageDimension ,height: imageDimension)
//                        .border(Color.white)
//                        .clipped()
//                }
//            }
//        }
//    }
}

//Text("애플 로그인 완료")
//
//Button {
//    DispatchQueue.global(qos: .background).async {
//        try? Auth.auth().signOut()
//    }
//
//    withAnimation(.easeInOut) {
//        logStatus = false
//    }
//
//} label: {
//    Text("Log Out")
//}
