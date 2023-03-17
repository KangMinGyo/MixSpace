//
//  MyView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/16.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    
    @AppStorage("logStatus") var logStatus = false
    @State private var selectionFilter: ProfileFilterViewModel = .space
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    let imageDimension = UIScreen.main.bounds.width / 3
    
    var body: some View {
        
        VStack {
            HeaderView
            
            filterBar
            
            gridView
            
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
            Color("SpaceBlue")

            HStack {
                Image("Profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("이훈이")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("주먹밥러버")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Button {
                        // 친구 목록으로 이동
                    } label: {
                        UserStatsView()
                    }
                }
                Spacer()
                
                Button {
                    //프로필 설정 (지금은 임시 로그아웃 버튼)
                    DispatchQueue.global(qos: .background).async {
                        try? Auth.auth().signOut()
                    }
                    
                    withAnimation(.easeInOut) {
                        logStatus = false
                    }
                } label: {
                    Image(systemName: "gearshape")
                        .font(.system(size: 24))
                        .foregroundColor(Color.gray)
                    
                }
            }
            .padding()
        }
        .frame(height: 300)
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
    }
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(0...4, id: \.self) { index in
                    Image("TestImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageDimension ,height: imageDimension)
                        .border(Color.white)
                        .clipped()
                }
            }
        }
    }
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
