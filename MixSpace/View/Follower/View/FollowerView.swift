//
//  FollowerView.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/18.
//

import SwiftUI

struct FollowerView: View {
    @ObservedObject var vm = FollowerViewModel()
    
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
            .navigationTitle("Follower")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FollowerView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerView()
    }
}
