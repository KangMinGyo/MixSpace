//
//  UserProfileViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/14.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var posts = [Post]()
    
    let postUser: User
    let service = UserService()
    let postService = PostService()
    
    init(postUser: User) {
        self.postUser = postUser
        fetchCurrentUser()
        fetchPosts()
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        service.fetchCurrentUser(uid: uid) { user in
            self.user = user
        }
    }
    
    func fetchPosts() {
        guard let uid = postUser.id else { return }
        postService.fetchPost(forUid: uid) { posts in
            self.posts = posts
            
            for i in 0 ..< posts.count {
                let uid = posts[i].uid
                
                self.service.fetchCurrentUser(uid: uid) { user in
                    self.posts[i].user = user
                }
            }
        }
    }
    
    func followingUser(userId: String) {
        service.followingUser(userId) {
            
        }
    }
    
//    func fetchPosts() {
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
//        postService.fetchPost(forUid: uid) { posts in
//            self.posts = posts
//
//            for i in 0 ..< posts.count {
//                let uid = posts[i].uid
//
//                self.service.fetchCurrentUser(uid: uid) { user in
//                    self.posts[i].user = user
//                }
//            }
//        }
//    }
}
