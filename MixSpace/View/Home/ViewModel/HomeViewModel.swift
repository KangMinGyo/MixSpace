//
//  HomeViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/17.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    let service = PostService()
    let userService = UserService()
    
    init() {
        fetchPost()
    }
    
    func fetchPost() {
        service.fetchPost { posts in
            self.posts = posts
            
            for i in 0 ..< posts.count {
                let uid = posts[i].uid
                
                self.userService.fetchCurrentUser(uid: uid) { user in
                    self.posts[i].user = user
                }
            }
        }
    }
}
