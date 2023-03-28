//
//  ProfileEditView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/21.
//

import SwiftUI

struct ProfileEditView: View {

    @Environment(\.dismiss) private var dismiss
    
    @StateObject var vm = ProfileEditViewModel()
    
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
        .navigationTitle("프로필 편집")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.editCurrentUser()
                    dismiss()
                    
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
            TextField(text: $vm.name) {
                Text(vm.name)
                    .foregroundColor(.gray)
            }
            Divider()
            
            Text("별명")
            TextField(text: $vm.nickName) {
                Text(vm.nickName)
                    .foregroundColor(.gray)
            }
            Divider()
            
            Text("소개")
            TextField(text: $vm.introText) {
                Text(vm.introText)
                    .foregroundColor(.gray)
            }
            Divider()
        }
        .padding()
    }
}
