//
//  FriendList.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/18.
//

import SwiftUI

struct FriendListView: View {
    @ObservedObject var vm = FriendListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(vm.users, id: \.self) { user in
                            NavigationLink {
                                UserProfileView(user: user)
                            } label: {
                                UserRowProfile(user: user)
                            }
                        }
                    }
                }
            }
            .navigationTitle("친구 목록")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListView()
    }
}
