//
//  ProfileViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/16.
//

import Foundation

enum ProfileFilterViewModel: Int, CaseIterable {
    case post
    case liked
    
    var title: String {
        switch self {
        case .post: return "post"
        case .liked: return "liked"
            
        }
    }
}
