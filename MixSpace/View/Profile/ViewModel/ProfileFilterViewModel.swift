//
//  ProfileViewModel.swift
//  MixSpace
//
//  Created by KangMingyo on 2023/03/16.
//

import Foundation

enum ProfileFilterViewModel: Int, CaseIterable {
    case space
    case liked
    
    var title: String {
        switch self {
        case .space: return "space"
        case .liked: return "liked"
            
        }
    }
}
