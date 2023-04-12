//
//  SearchViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/05.
//

import Foundation

class SearchViewModel: ObservableObject {
    let service = UserService()
    
    @Published var users = [User]()
    @Published var searchText = ""
    
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            let lowercasedQuery = searchText.lowercased()
            
            return users.filter({
                $0.name.contains(lowercasedQuery) ||
                $0.nickName.contains(lowercasedQuery)
            })
        }
    }
    
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
