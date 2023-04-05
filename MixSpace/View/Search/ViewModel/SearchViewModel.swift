//
//  SearchViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/05.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    let service = UserService()
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
            
            print("DEBUG: Users \(users)")
        }
    }
}
