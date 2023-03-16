//
//  MyView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/16.
//

import SwiftUI
import Firebase

struct MyView: View {
    
    @AppStorage("logStatus") var logStatus = false
    
    var body: some View {
        ScrollView {
            VStack {
                HeaderView

                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}

extension MyView {
    private var HeaderView: some View {
        ZStack(alignment: .bottomLeading) {
            Color("SpaceBlue")
            
            HStack {
                Image("TestProfile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72, height: 72)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("이훈이")
                        .foregroundColor(.white)
                    
                    Button {
                        // 친구 목록으로 이동
                    } label: {
                        HStack {
                            Text("2 Following")
                                .foregroundColor(.white)
                            Text("7 Followers")
                                .foregroundColor(.white)
                        }
                    }
                }
                Spacer()
                
                Button {
                    //프로필 설정
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
