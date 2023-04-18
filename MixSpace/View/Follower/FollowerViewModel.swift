//
//  FollowerViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/18.
//

import Foundation

class FollowerViewModel: ObservableObject {
    let service = ProfileService()
    
    @Published var users = [User]()
    
    init() {
        fetchFollower()
    }
    
    func fetchFollower() {
        service.fetchFollower { users in
            self.users = users
        }
    }
}
