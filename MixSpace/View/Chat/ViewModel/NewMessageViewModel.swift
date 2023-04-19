//
//  NewMessageViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/19.
//

import Foundation

class NewMessageViewModel: ObservableObject {
    let service = ProfileService()
    
    @Published var users = [User]()
    
    init() {
        fetchFollwingUsers()
    }
    
    func fetchFollwingUsers() {
        service.fetchFollowing { users in
            self.users = users
        }
    }
}
