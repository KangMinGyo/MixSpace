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
    @Published var likedPosts = [Post]()
    
    let service = UserService()
    let postService = PostService()
    
    init() {
        fetchCurrentUser()
        fetchPosts()
        fetchLikedPosts()
    }
    
    func posts(forFilter filter: ProfileFilterViewModel) -> [Post] {
        switch filter {
        case .post:
            return posts
        case .liked:
            return likedPosts
        }
    }
    
    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        service.fetchCurrentUser(uid: uid) { user in
            self.user = user
        }
    }
    
    func fetchPosts() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
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
    
    func fetchLikedPosts() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        postService.fetchLikedPosts(forUid: uid) { posts in
            self.likedPosts = posts
            
            for i in 0 ..< posts.count {
                let uid = posts[i].uid
                
                self.service.fetchCurrentUser(uid: uid) { user in
                    self.likedPosts[i].user = user
                }
            }
        }
    }
}
