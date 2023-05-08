//
//  FriendListViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/18.
//

import Foundation

class FriendListViewModel: ObservableObject {
    let service = ProfileService()
    
    @Published var users = [User]()
    
    init() {
        fetchFollowing()
    }
    
    func fetchFollowing() {
        service.fetchFollowing { users in
            self.users = users
        }
    }
}
