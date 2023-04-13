//
//  profileViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/21.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var posts = [Post]()
    
    let service = UserService()
    let postService = PostService()
    
    init() {
        fetchCurrentUser()
        fetchUserPosts()
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        service.fetchCurrentUser(uid: uid) { user in
            self.user = user
        }
    }
    
    func fetchUserPosts() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        postService.fetchPosts(forUid: uid) { posts in
            self.posts = posts
            
            for i in 0 ..< posts.count {
                let uid = posts[i].uid
                
                self.service.fetchCurrentUser(uid: uid) { user in
                    self.posts[i].user = user
                }
            }
        }
    }
}

//func fetchPost() {
//    service.fetchPost { posts in
//        self.posts = posts
//        
//        for i in 0 ..< posts.count {
//            let uid = posts[i].uid
//
//            self.userService.fetchCurrentUser(uid: uid) { user in
//                self.posts[i].user = user
//            }
//        }
//    }
//}
