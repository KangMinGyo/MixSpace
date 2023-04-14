//
//  NewPostViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/04/14.
//

import Foundation

class NewPostViewModel: ObservableObject {
    private let service = PostService()
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
        checkIfUserLikedPost()
    }
    
    func likePost() {
        service.likePost(post) {
            self.post.didLike = true
        }
    }
    
    func checkIfUserLikedPost() {
        service.checkIfUserLikedPost(post) { didLike in
            if didLike {
                self.post.didLike = true
            }
        }
    }
}
