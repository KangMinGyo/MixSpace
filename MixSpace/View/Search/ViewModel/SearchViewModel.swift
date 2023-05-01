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
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.fireStore.collection("users")
            .getDocuments { snapshot, err in
                if let err = err {
                    print("친구 불러오는거 실패했어잉,,\(err)")
                    return
                }
                
                snapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
                    let user = User(data: data)
                    if user.uid != uid {
                        self.users.append(.init(data: data))
                    }
                })
            }
    }
}
