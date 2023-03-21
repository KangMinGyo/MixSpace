//
//  ProfileEditView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/21.
//

import SwiftUI

struct ProfileEditView: View {
    
    @State var name: String = ""
    @State var nickName: String = ""
    @State var introduce: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    photoEditView
                    
                    infoEditView
                    
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
        .navigationTitle("프로필 수정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //프로필 수정
                } label: {
                    Text("완료")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView()
    }
}

extension ProfileEditView {
    private var photoEditView: some View {
        ZStack(alignment: .bottomLeading) {
            ZStack {
                Color("SpaceWhite")
                
                Button {
                    // 배경사진 변경
                } label: {
                    Rectangle()
                        .frame(height: 300)
                        .foregroundColor(.clear)
                }
            }

            VStack(alignment: .leading) {
                HStack {
                    ZStack {
                        Image("Profile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72, height: 72)
                            .clipShape(Circle())
                        
                        Button {
                            //프로필 사진 변경
                        } label: {
                            Circle()
                                .frame(width: 72, height: 72)
                                .foregroundColor(.clear)
                                
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .frame(height: 300)
    }
    
    private var infoEditView: some View {
        VStack(alignment: .leading) {
            Text("이름")
            TextField(text: $name) {
                Text("이훈이")
            }
            Divider()
            
            Text("별명")
            TextField(text: $nickName) {
                Text("주먹밥러버")
            }
            Divider()
            
            Text("소개")
            TextField(text: $introduce) {
                Text("주먹밥머리 훈이예용")
            }
            Divider()
        }
        .padding()
    }
}
