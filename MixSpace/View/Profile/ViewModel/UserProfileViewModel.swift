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
    
    var postUser: User
    let service = UserService()
    let postService = PostService()
    let profileService = ProfileService()
    
    init(postUser: User) {
        self.postUser = postUser
        fetchCurrentUser()
        fetchPosts()
        checkFollowState()
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
    
    //MARK: Following & Follower
    
    func followingUser() {
        guard let user = user else { return }
        profileService.followingUser(user: user, postUser: postUser) {
            print()
        }
        profileService.followerUser(user: user, postUser: postUser) {
            print()
        }
    }
    
    func unfollowingUser() {
        guard let uid = postUser.id else { return }
        guard let user = user else { return }
        profileService.unfollowingUser(user: user, userId: uid) {
            print("언팔로우 완료?")
        }
        profileService.unfollowerUser(user: user, userId: uid) {
            print("언완.")
        }
    }

    func checkFollowState() {
        guard let uid = postUser.id else { return }
        profileService.checkFollowState(userId: uid) { didFollow in
            if didFollow {
                self.postUser.didFollow = true
            }
        }
    }
}
